---

## 一、新增文件

src/05-skill-patterns.md

````markdown
# 技能实现模板（Skill Patterns）

> 本文件是新增职业技能的"照抄模板"。
> 版本红线：Minecraft Java Edition 1.20.1 数据包（pack_format 15）。
> 任何 1.20.2+ 语法出现即报错，详见 `00-version.md`。
> 现有参照实现：战士（补给·自动）、弓箭手（换弹·触发器驱动）、坦克（举盾·主动）、刺客（隐匿·主动）。

---

## 一、技能分两类

| 类型 | 触发方式 | 入口函数 | 是否进 `skill/dispatch` |
|---|---|---|---|
| 自动技能 | 冷却归零即自动结算 | `skill/<职业>` | 进 |
| 主动技能 | 玩家右键消耗令牌 | `skill/<职业>_cast` | 不进 |

- 自动技能链路：`tick` → `skill/dispatch`（筛 `cd<=0`）→ `skill/<职业>`。
- 主动技能链路：`tick` 检测 `used > last` → `skill/<职业>_cast` → `skill/<职业>_fire`。
- 两种技能共用同一个冷却变量 `kitpvp.cd`（第二技能用 `kitpvp.cd2`）。
- 两种技能都必须经过 `cd` 闸门，不允许绕过。

---

## 二、主动技能：令牌机制

### 2.1 令牌 = 刷怪蛋

1.20.1 没有自定义物品，主动技能的"施法按钮"用**刷怪蛋**充当。

- 选颜色贴主题的刷怪蛋：
  - 坦克 → `minecraft:iron_golem_spawn_egg`（铁傀儡）
  - 刺客 → `minecraft:enderman_spawn_egg`（末影人）
  - 新增职业时按"颜色 + 形象贴主题"选，不要随便挑。
- 右键刷怪蛋的瞬间，原版 `minecraft.used:minecraft.<egg>` 统计自动 +1，这就是"按下右键"的信号。
- 令牌本体不带任何技能效果，效果全部由 `<职业>_fire` 给。

### 2.2 令牌 NBT

```mcfunction
give @s minecraft:iron_golem_spawn_egg{KitTankEgg:1b,display:{Name:'{"text":"举盾令牌","color":"aqua","bold":true}'}} 1
```

- `Kit<职业>Egg:1b` 是本职业技能识别令牌的私有标记。
- `display.Name` 是 1.20.1 旧版文本组件 JSON，内层双引号要转义。
- **刷怪蛋的 `display.Name` 会成为生成生物的 CustomName**（原版行为，已实测确认）。
  所以 tick 清怪可以用 `name="举盾令牌"` 精确匹配，不必再给生物单独打 tag。

### 2.3 幂等发放

```mcfunction
execute unless data entity @s Inventory[{tag:{KitTankEgg:1b}}] run give @s minecraft:iron_golem_spawn_egg{KitTankEgg:1b,display:{Name:'{"text":"举盾令牌","color":"aqua","bold":true}'}} 1
```

- 用 `Inventory[{tag:{...}}]` 检查背包里是否已存在该标记的物品。
- 已存在时不重复发放，避免堆叠。

---

## 三、主动技能：三层函数结构（强制）

| 函数 | 职责 | 调用方 |
|---|---|---|
| `skill/<职业>_give_egg` | 幂等发令牌 | `kit/<职业>`、`tick`、`player/after_death` |
| `skill/<职业>_cast` | 入口：推快照 + 判 `cd` | `tick` |
| `skill/<职业>_fire` | 给效果 + 给物品 + `set cd` | `<职业>_cast` |
| `skill/<职业>_expire` | 到期清理（可选） | `tick` |

### 3.1 `<职业>_cast.mcfunction` 骨架

```mcfunction
# 首行必须是快照推进，漏写会造成无限连放
scoreboard players operation @s kitpvp.<职业>_last = @s kitpvp.<职业>_used

execute if score @s kitpvp.cd matches ..0 run function kitpvp:skill/<职业>_fire
execute if score @s kitpvp.cd matches 1.. run title @s actionbar {"text":"XX冷却中","color":"gray"}
```

- 首行快照推进是**铁律**：不推进，下一刻 `used > last` 依旧成立，技能每刻触发。
- `cd<=0` → 释放；`cd>0` → 仅提示（玩家捡起旧令牌又右键的兜底）。

### 3.2 `<职业>_fire.mcfunction` 骨架

```mcfunction
effect give @s minecraft:<效果> <持续秒> <等级> true
tag @s add kitpvp.<职业>_active

# set cd 必须是最后一步
scoreboard players set @s kitpvp.cd <总刻数>

title @s actionbar {...}
playsound minecraft:<音效> master @s ~ ~ ~ 0.8 1.0
```

- `set cd` 写在函数最后，冷却从"释放一瞬间"开始计时。
- 给临时效果要带 `true`（隐藏粒子）。

---

## 四、时间轴拆分（同一 cd 表达"效果期 + 冷却期"）

把总冷却拆成两段，用同一个 `kitpvp.cd` 变量表达：

```
cd = 600（30 秒）
  ├─ 前 N 刻：效果生效期
  └─ 后 600-N 刻：纯冷却期
```

- 到期判定条件写 `cd=..N`（不是 `=N`）。
  用 `..N` 是因为服务端卡顿可能跳刻，`=N` 会漏触发。
- 配一个 tag（`kitpvp.<职业>_active`）保证每个技能效果只清一次：

```mcfunction
execute as @a[scores={kitpvp.cd=..N},tag=kitpvp.<职业>_active,tag=!kitpvp.spectator] run function kitpvp:skill/<职业>_expire
```

现有两套参照：

| 职业 | 总 cd | 效果期 | 到期阈值 | tag |
|---|---|---|---|---|
| 坦克 | 600（30 秒） | 300（15 秒持盾） | `..300` | `kitpvp.shield_held` |
| 刺客 | 600（30 秒） | 100（5 秒隐身） | `..500` | `kitpvp.assassin_hidden` |

---

## 五、临时高等级效果会顶掉永久效果（高频坑）

Minecraft 中"同一效果的更高等级会**替换**低等级，而不是叠加"。

- 刺客案例：隐匿给 speed III(amp 2)，会把刺客的永久 speed I(amp 0) 顶掉。
  5 秒后 speed III 消失，**speed I 不会自动回来**。
- 处理方式：在 `<职业>_expire` 里重新挂回永久效果。

```mcfunction
function kitpvp:kit/<职业>_passive
```

- 同理，**隐身效果本身不要主动 `effect clear`**，交给原版计时器。
  这样即使玩家中途死亡重生，也不会残留"隐身碎片"。
- 新增"临时给高等级效果"的技能时，必问：这个效果会不会顶掉职业的永久效果？

---

## 六、到期清理（`<职业>_expire` 骨架）

```mcfunction
clear @s minecraft:<物品>{Kit<职业>:1b}
tag @s remove kitpvp.<职业>_active

title @s actionbar {"text":"XX已消失","color":"gray"}
```

- `clear @s <item>{<nbt>}` 是 1.20.1 的写法，NBT 直接挂在物品 id 后。
- `clear` **只清背包**，清不掉：光标上的、末影箱里的、**已经丢到地上的**。
- 已知取舍：丢到地上的技能物品不会被回收。若物品有耐久（如坦克的盾 `Damage:256`），
  流出的那份用完即碎，不构成刷物品漏洞。

---

## 七、快照变量（`*_last`）铁律

每个主动技能都需要一个统计 objective（`minecraft.used:...`）和一个快照变量（`*_last`）。

| 项 | 内容 |
|---|---|
| 统计 objective | `kitpvp.<职业>_used`，类型 `minecraft.used:minecraft.<egg>` |
| 快照变量 | `kitpvp.<职业>_last`，类型 `dummy` |

**快照变量必须在三处同步初始化**（漏一处就会误判"刚用过"）：

1. `load.mcfunction` —— 创建 objective 与假玩家/常量初始化
2. `player/join.mcfunction` —— 新玩家进服时把 `last` 推到 `used` 当前值
3. `util/clear_player.mcfunction` —— 清场/换职业/重生时同步

现有清单：`gapple_last`、`tank_last`、`assassin_last`、`ready_last`、`death_seen`。
**新增任何 `*_last` 时三处都要补。**

例外：`ready_last` 的初始化在 `lobby/enter` 里（因为只有进大厅后才需要快照）。

---

## 八、清怪（令牌生成物的回收）

令牌是刷怪蛋，右键会在玩家附近生成一只生物。tick 要把它立刻清掉，只保留"按下右键"信号：

```mcfunction
execute as @a[scores={kitpvp.kit=<N>}] at @s run kill @e[type=<生物类型>,distance=..16,name="XX令牌"]
```

- `distance=..16` 覆盖刷怪蛋最大右键射程（约 4.5 格），并避免误杀远处同种生物。
- **副作用**：若地图自带装饰性同种生物且落在该玩家 16 格内，会被一并清掉。
  任何 `kill @e` 都要在注释里写明可能误杀什么。

---

## 九、兜底补发与已知漏洞

tick 里对令牌做兜底补发：

```mcfunction
execute as @a[scores={kitpvp.kit=<N>,kitpvp.alive=1,kitpvp.cd=0},tag=!kitpvp.spectator] unless data entity @s Inventory[{tag:{Kit<N>Egg:1b}}] run function kitpvp:skill/<职业>_give_egg
```

### 9.1 已知漏洞：丢令牌 → 补发

- 判据是"背包里没有令牌就补"，所以玩家**把令牌丢地上**也会触发补发。
- 危害评估：补发的是普通刷怪蛋，只有对应职业右键才触发技能，所以：
  - 非该职业玩家捡到令牌右键 → 只生成一只普通生物，不触发技能（tick 会清），无实际收益。
  - 该职业玩家在 `cd=0` 时反复丢 → 反复补，但用掉一次就进冷却，不放大技能次数。
- **结论**：当前接受该漏洞。新增同类职业前，必须重新评估这条前提是否仍然成立。

### 9.2 非施法者捡到令牌

- 非该职业玩家捡到令牌右键，生成生物后若无该职业玩家在 16 格内，生物不会被清。
- 当前接受；若某张地图出现大量此类生物堆积，再考虑加全局清理。

---

## 十、新增主动技能自检清单

- [ ] 令牌刷怪蛋颜色是否贴主题？NBT 标记是否用 `Kit<职业>Egg:1b`？
- [ ] 令牌发放是否幂等（`Inventory[{tag:{...}}]` 检查）？
- [ ] 统计 objective 是否已建（`minecraft.used:minecraft.<egg>`）？
- [ ] 快照变量 `*_last` 是否在 `load` / `player/join` / `util/clear_player` 三处初始化？
- [ ] `<职业>_cast` 首行是否为 `operation last = used`？
- [ ] `<职业>_fire` 的 `set cd` 是否在最后一步？
- [ ] 到期判定是否用 `cd=..N` 而非 `=N`？是否有配对的 `*_active` tag？
- [ ] 临时高等级效果会不会顶掉职业永久效果？`<职业>_expire` 是否重挂？
- [ ] 令牌生成物是否有 tick 清怪行？清怪范围与误杀是否写进注释？
- [ ] 兜底补发行是否只在 `cd=0` 时生效？
- [ ] tick 检测行是否按固定顺序放置（见 `04-hazards-reminder.md` 第六节）？

---

## 十一、新增自动技能自检清单

- [ ] 是否在 `skill/dispatch` 里追加一行 `execute if score @s kitpvp.kit matches <N> run function kitpvp:skill/<职业>`？
- [ ] 技能函数末尾是否自己 `set cd <刻数>`？（漏写会每刻重复触发）
- [ ] 条件未满足时（上限满、环境不对）是否 `set cd 0` 或不动，让下一刻重试？
- [ ] 若发物品，冷却判据是"真正使用"还是"背包里没有"？（见 `04-hazards-reminder.md` 第四节）
- [ ] 若用 `minecraft.used:`，该物品在本服是否只有一个来源？
````

---