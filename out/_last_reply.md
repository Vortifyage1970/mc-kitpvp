# 延展方案

下面这一整段，追加到 `src/05-skill-patterns.md` 的末尾（接在现有"十一、新增自动技能自检清单"之后）。里面提到的 mcfunction 片段按 1.20.1 红线写，可直接照抄。

---

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

写完这段后，同步两件小事：

- `03-project-spec.md` § 七.tag 登记表新增两行（`kitpvp.hold_fb` / `kitpvp.hold_fb_prev`，add 于 `tick`、remove 于 `tick` 下一轮、clear_player **不清**）。
- `01-file-structure.md` 目录树在 `skill/` 下补 `arsonist_fire.mcfunction`。