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

## 五、临时效果与永久效果的关系（已实测确认）

**实测结论**：同一种状态效果，临时高等级与永久低等级**可以共存**。
临时高等级到期后，低等级会**自动继续生效**，不需要手动补挂。

- 例：刺客常驻 speed I，隐匿期间给 speed III。
  5 秒后 speed III 到期，speed I 自动恢复，**不需要在 `assassin_unhide` 里重挂**。
- 例：坦克常驻 slowness I，若某技能给 slowness III，到期后同样自动回落。

### 5.1 由此得出的三条约定

1. **`<职业>_expire` 不负责重挂永久效果。**
   到期清理只做三件事：清物品、摘 `*_active` tag、提示玩家。
   禁止在 `_expire` 里写 `function kitpvp:kit/<职业>_passive`。

2. **临时技能永远不要用 `effect clear @s`。**
   `effect clear @s` 不带参数时清掉全部效果，带 `@s <效果>` 时清掉该效果的**所有等级**——
   两种用法都会把职业永久效果一并抹掉。
   临时效果交给原版计时器自然到点即可。

3. **重生 / 清场后仍需重挂永久效果。**
   `util/clear_player.mcfunction` 里的 `effect clear @s` 是无差别清空，
   所以"重生后重挂被动"这件事仍然要做，位置在 `player/after_death` 或 `kit/<职业>` 里。
   （`player/join` 也走 `kit/*`，所以新玩家同样能拿到。）

### 5.2 自动回落不改变 `_expire` 的必要性

`<职业>_expire` 仍然必须存在，因为它的职责是清**物品**（坦克的盾、刺客的令牌），
与效果无关。tag 配对规则（`cd=..N` + `*_active`）也不变。

### 5.3 现有两套参照

| 职业 | 总 cd | 效果期 | 到期阈值 | tag | `_expire` 是否重挂被动 |
|---|---|---|---|---|---|
| 坦克 | 600（30 秒） | 300（15 秒持盾） | `..300` | `kitpvp.shield_held` | 否（技能不涉及效果） |
| 刺客 | 600（30 秒） | 100（5 秒隐身） | `..500` | `kitpvp.assassin_hidden` | **否**（实测后删除，原方案作废） |


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
- [ ] 临时技能是否误用了 `effect clear @s`？（不带参数清全部效果，带参数清该效果所有等级，都会抹掉职业永久效果）
- [ ] `<职业>_expire` 里是否残留了 `function kitpvp:kit/<职业>_passive`？有就删掉——高等级到期后低等级会自动回落。
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

## 十二、投掷类技能：多来源统计的污染与分流

> 适用对象：施法载体是**喷溅药水**（或任何本服可能有第二个来源的物品）的职业。
> 现有参照：纵火狂（`splash_potion` + `KitFireBomb:1b`）。
> 本章的核心结论一句话：**投掷类技能的"入口触发"可以用统计 objective，但"是不是本职业的投掷物"必须另用上一刻手持 NBT 分流；而 last 快照的推进绝不能带任何前置条件。**

---

### 12.1 问题：`minecraft.used:splash_potion` 是全服合并统计

`scoreboard objectives add ... minecraft.used:minecraft.<item>` 只覆盖原版物品，且**不分来源、不分 NBT**：任何玩家投出任何一瓶喷溅药水，都会让**该玩家自己**的该 objective +1。

纵火狂刚落地时本服只有它一个来源，所以 `used > last` 是可靠的。一旦出现以下任一情况，投掷入口立即被污染：

- 新增**药剂师**职业，技能也是投掷药水；
- **药剂师魂石**（或其它魂石）设计成"给全职业一瓶喷溅药水"；
- 地图野刷/装饰刷新了喷溅药水；
- 未来任何"发喷溅药水"的机制。

污染后纵火狂的 `used > last` 会误判：玩家投的是别人的药水，纵火狂自己却被扣弹药、进 45 秒冷却。

**判据**：只要 `minecraft.used:minecraft.<item>` 对应的物品在本服**不是唯一来源**，就必须走本章的分流方案，不能沿用"只判 used > last"的简化写法。

---

### 12.2 只判 `used > last` 会翻车的具体路径

假设照抄"只判 used > last"的写法（哪怕额外在 tick 的**调用条件**里加了 `hold_*_prev` 闸门，也是错的），出问题的时序是：

| 时刻 | 玩家动作 | `used` | `hold_fb_prev` | 结果 |
|---|---|---|---|---|
| t0 | 投一瓶**普通**药水 | +1 | false | 入口条件不成立 → **cast 不被调 → `last` 没推进** |
| t1..tn | 什么都不投，切到燃烧瓶 | 不变 | 变 true | `used > last` **仍然成立** |
| tn+1 | 拿着燃烧瓶站着 | 不变 | true | ↓ 被触发，误报"燃烧瓶已投出"，白扣弹药 + 45 秒冷却 |

**根因**：`last` 是"上一次被本次投掷消费掉的 used 值"。它必须**无条件吃掉每一次喷溅药水投掷**——包括不是燃烧瓶的那一瓶。只要有一次投掷没被"吃掉"，`used > last` 就会一直悬在那，等下一次 `hold_*_prev` 变 true 时错误兑现。

**这条坑位与"投掷类技能"强绑定，写在 04 里也成立，此处展开成方案。**

---

### 12.3 1.20.1 能用的手段

| 手段 | 1.20.1 是否可用 | 说明 |
|---|---|---|
| `execute if items` | ❌ | 1.20.5+ 才有 |
| 宏 `$()` / 函数参数 | ❌ | 1.20.2+ 才有 |
| `advancement` 触发器捕捉"投掷喷溅药水" | ❌ | 1.20.1 没有任何触发器对应"投掷"这个动作（`consume_item` 是吃/喝，`item_used_on_block` 是对着方块用，`throw_item` 不存在） |
| `execute if data entity @s SelectedItem.tag.<标记>` | ✅ | 判断**主手**物品的 NBT 路径是否存在 |
| `minecraft.used:minecraft.splash_potion` | ✅ | 只能当"投了**某个**喷溅药水"的粗筛信号 |

**结论**：粗筛信号（`used` 增长） + 上一刻手持物品 NBT（`SelectedItem.tag`）组合做分流。这是 1.20.1 在纯数据包下唯一可靠的写法。

---

### 12.4 方案：holding / prev 双层 tag 分流

每个投掷类职业技能配**一对私有 tag**：

| tag | 语义 | 何时成立 |
|---|---|---|
| `kitpvp.hold_<abbr>` | **当前**主手拿着本职业的投掷物 | 每刻重建 |
| `kitpvp.hold_<abbr>_prev` | **上一刻**主手拿着本职业的投掷物 | 每刻从上一刻的 `hold_<abbr>` 推进 |

`<abbr>` 取职业英文缩写：纵火狂 `fb`（firebomb），药剂师 `pa`（potion alchemist）。

**必须用 prev，不能用当前值**：投掷那一刻物品已经离开主手，`SelectedItem` 已经变了。看当前值永远捕捉不到"投掷这一帧"。

**tag 不写入 `load` / `util/clear_player`**：它们每刻被 tick 重建，清场时被清掉无意义，下一 tick 又会正确重建。

---

### 12.5 铁律：`last` 推进必须无条件

这是本章最重要的一条，写死：

> **`<职业>_cast` 的首行 `<职业>_last = <职业>_used` 在任何情况下都必须被调用、必须被执行。**
> **"是不是本职业的投掷物"这层判断，只能放在 cast 之后的 fire 里。**

对应到代码结构，`cast` 的**调用条件**里**绝对不能**出现 `hold_<abbr>_prev`。反例与正例：

反例（会触发 12.2 的 bug，禁止）：

```mcfunction
execute as @a[tag=kitpvp.hold_fb_prev,scores={kitpvp.kit=5}] if score @s kitpvp.arsonist_used > @s kitpvp.arsonist_last run function kitpvp:skill/arsonist_cast
```

正例（cast 无条件被调，`last` 无条件被推）：

```mcfunction
execute as @a[scores={kitpvp.kit=5,kitpvp.alive=1},tag=!kitpvp.spectator] if score @s kitpvp.arsonist_used > @s kitpvp.arsonist_last run function kitpvp:skill/arsonist_cast
```

注意：**正例里也不带 `hold_fb_prev`**。`hold_fb_prev` 的闸门在 `cast` 内部，用它决定"要不要调 fire"。这是"先统一消费 last，再按情况施法"的两段式。

---

### 12.6 标准函数结构

投掷类技能把 `_cast` 拆成两部分：`_cast`（推 last + 分流）和 `_fire`（真施法）。这与第五章"三层结构"里 `<职业>_cast → <职业>_fire" 的分工一致，只是 `_cast` 里"判断是否施法"的判据从 cd 变成 `hold_*_prev`。

| 函数 | 职责 | 调用方 |
|---|---|---|
| `skill/<职业>_cast` | ① 无条件推 `last` ② 若 `hold_*_prev` 成立，调 `_fire` | `tick` |
| `skill/<职业>_fire` | 扣弹药 + `set cd` + 提示 + 音效 | `_cast` |
| `skill/<职业>` | 自动补货（沿用原有） | `skill/dispatch` |
| `skill/<职业>_give` | 发一份投掷物（沿用原有） | `skill/<职业>` |

`tick` 段固定顺序：**A 推进 prev → B 重建当前 → C 无条件投掷入口**。三段顺序不能换。

#### 12.6.1 tick 段（以纵火狂为例）

src/data/kitpvp/functions/tick.mcfunction（纵火狂段）

```mcfunction
# ===== 纵火狂 =====
# 喷溅药水本服有多个来源（纵火狂本体、后续药剂师、魂石、野刷），
# minecraft.used:splash_potion 只能当粗筛信号，不能单独作为施法依据。
# 分流方式：
#   A. 每刻把"上一刻手持燃烧瓶"记进 kitpvp.hold_fb_prev
#   B. 每刻重建"当前手持燃烧瓶"= kitpvp.hold_fb
#   C. 只要有喷溅药水投掷（used 增长）就调 arsonist_cast；
#      "是不是燃烧瓶"由 cast 内部用 hold_fb_prev 决定
# ⚠ C 的调用条件里绝对不能加 hold_fb_prev：否则投其它药水时 last 不推进，
#   之后切到燃烧瓶会把历史投掷当成新投掷，误触发一次施法。

# A. 推进 prev（引用上一刻的 hold_fb）
tag @a remove kitpvp.hold_fb_prev
tag @a[tag=kitpvp.hold_fb] add kitpvp.hold_fb_prev

# B. 重建当前刻 hold_fb
tag @a remove kitpvp.hold_fb
execute as @a if data entity @s SelectedItem.tag.KitFireBomb run tag @s add kitpvp.hold_fb

# C. 投掷入口（无条件调用，由 cast 内部用 hold_fb_prev 分流）
execute as @a[scores={kitpvp.kit=5,kitpvp.alive=1},tag=!kitpvp.spectator] if score @s kitpvp.arsonist_used > @s kitpvp.arsonist_last run function kitpvp:skill/arsonist_cast

# 燃烧瓶即将落地 → 铺火
execute as @e[type=minecraft:potion,nbt={Item:{tag:{KitFireBomb:1b}}},tag=!kitpvp.arsonist_burst] at @s unless block ~ ~-0.5 ~ air unless block ~ ~-0.5 ~ cave_air unless block ~ ~-0.5 ~ void_air run function kitpvp:skill/arsonist_burst

# 掉进虚空的燃烧瓶
kill @e[type=minecraft:potion,nbt={Item:{tag:{KitFireBomb:1b}}},y=-100,dy=100]

# 火焰 5 秒保护
function kitpvp:skill/arsonist_flame_tick
```

#### 12.6.2 `<职业>_cast` 骨架

src/data/kitpvp/functions/skill/arsonist_cast.mcfunction

```mcfunction
# ===== 纵火狂：喷溅药水投掷入口 =====
# 触发：tick.mcfunction 检测到 kitpvp.arsonist_used > kitpvp.arsonist_last
#       ⚠ 触发条件里不含 hold_fb_prev——任何喷溅药水投掷都要进这里，
#         否则投普通药水时 last 不推进，之后切到燃烧瓶会误触发一次施法。
# @s = 纵火狂
#
# 本函数只做两步：
#   1. 无条件推进 last（把"这次投掷"标记为已消费）
#   2. 只有当"上一刻手持燃烧瓶"时，才转交 arsonist_fire 做真施法

scoreboard players operation @s kitpvp.arsonist_last = @s kitpvp.arsonist_used

execute if entity @s[tag=kitpvp.hold_fb_prev] run function kitpvp:skill/arsonist_fire
```

#### 12.6.3 `<职业>_fire` 骨架

src/data/kitpvp/functions/skill/arsonist_fire.mcfunction

```mcfunction
# ===== 纵火狂：燃烧瓶真施法 =====
# 调用方：skill/arsonist_cast（已确认上一刻手持带 KitFireBomb 标记的物品）
# @s = 纵火狂
#
# 弹药扣减、冷却、提示、音效集中在这里。
# last 推进已在 arsonist_cast 里做完，本函数不再重复。

execute if score @s kitpvp.arsonist_ammo matches 1.. run scoreboard players remove @s kitpvp.arsonist_ammo 1

scoreboard players set @s kitpvp.cd 900

title @s actionbar {"text":"燃烧瓶已投出","color":"gold"}
playsound minecraft:entity.splash_potion.throw master @s ~ ~ ~ 0.8 1.0
```

**结构性提醒**：`_cast` 与 `_fire` 拆分后，`01-file-structure.md` 目录树要新增 `<职业>_fire.mcfunction` 一行。`_fire` 的逻辑可以整体从旧 `_cast` 里搬过来，只是末尾不再需要重复推 `last`。

---

### 12.7 时序验证（四场景，全通过）

假设数据包 tick 在实体 tick 之后跑，`hold_fb_prev` = 上一 tick 数据包算出的 `hold_fb`。

| 场景 | `used` 变 | `hold_fb_prev` | cast 被调？ | fire 被调？ | 判定 |
|---|---|---|---|---|---|
| 一直手持燃烧瓶 → 投燃烧瓶 | +1 | true | ✅ | ✅ | 正确施法 |
| 一直手持普通药水 → 投普通药水 | +1 | false | ✅（推 last） | ❌ | 正确忽略 |
| 投完普通药水 → 切到燃烧瓶、**不再投** | 不变 | 变 true | ❌（used 不增长） | ❌ | 正确忽略 |
| 投完普通药水 → 切到燃烧瓶 → **再投燃烧瓶** | +1 | true | ✅ | ✅ | 正确施法 |

第三行是修复的关键：普通药水投出去那一刻，`last` 已经被无条件推到 `used` 的当前值，之后无论切什么物品，`used - last = 0`，不会误触发。

---

### 12.8 新增投掷类职业自检清单

- [ ] 该职业的投掷物是否带有**唯一私有 NBT 标记**（如 `KitFireBomb:1b`）？不同职业的标记必须互不相同。
- [ ] 是否新增了 `minecraft.used:minecraft.<item>` 统计 objective？（在 `load` 里统一创建）
- [ ] 是否新增了 `kitpvp.<职业>_used` 与 `kitpvp.<职业>_last`？`last` 的快照初始化是否在 `load` / `player/join` / `util/clear_player` 三处都做了？
- [ ] 是否新增了 `kitpvp.hold_<abbr>` 与 `kitpvp.hold_<abbr>_prev` 这对 tag？（**不进** `load` / `clear_player`，每刻重建）
- [ ] `tick` 里这三行的顺序是否是"① 推 prev → ② 重建当前 → ③ 无条件投掷入口"？
- [ ] **投掷入口的调用条件里有没有出现 `hold_<abbr>_prev`？有过就删掉。**（本章铁律，最高优先）
- [ ] `<职业>_cast` 首行是否是 `operation @s kitpvp.<职业>_last = @s kitpvp.<职业>_used`，且**不带任何前置条件**？
- [ ] "是不是本职业的投掷物"的判断是否放在 `<职业>_fire` 的调用条件里（`execute if entity @s[tag=kitpvp.hold_<abbr>_prev]`），而不是 cast 里？
- [ ] 该物品在本服除了本职业技能外，还有没有其它来源？若有，本方案是否已覆盖分流？
- [ ] 落地处理（如 `arsonist_burst`）是否用 `Item.tag.<标记>` 精确筛选，不会误伤其它职业的药水？
- [ ] 落地/掉虚空清理行是否用同一标记？会不会误杀其它职业的药水实体？

---

### 12.9 已知取舍与边界

1. **一刻延迟**。检测用"上一刻持握"，所以玩家必须**持着本职业的投掷物再右键**，不能"先投、再切到投掷物"。这是原版行为上的必然，可接受。
2. **同刻极端情况**：上一刻手持本职业投掷物，这一刻投的是别的喷溅药水（1 刻内换手）。会误判一次。触发条件苛刻；误判后果是扣 1 弹药 + 进冷却，不影响胜负。
3. **`SelectedItem.tag.<标记>` 只判路径存在，不判值**。别给非本职业物品写 `<标记>:0b` 这种值，否则会被误认为本职业投掷物。真要用 0/1 值区分时，改走 predicate + `data get` 精确比较。
4. **不能只用当前刻 `hold_<abbr>`**。投掷那一帧物品已离开主手，看当前值永远错过。必须 prev。
5. **tag 每刻重建**。不要为了"省一次 tag 操作"改成持久 tag；持久 tag 会在投掷物"用光但还没补货"期间误报持握。
6. **同 objective 多职业共存**。如果两个职业共用同一个 `minecraft.used:minecraft.splash_potion`（= 使用同一个 objective 名），它们各自的 `*_last` 互不影响 —— **前提是每个 cast 都无条件推进自己的 last**。这条仍然回到 12.5 的铁律。

---