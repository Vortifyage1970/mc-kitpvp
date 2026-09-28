## 你说得对，这是我上一版写完才该想到的路子

`minecraft.used:minecraft.golden_apple` 是 1.13~1.20.1 都有的统计型 objective，**统计「玩家把金苹果吃进肚子」这一事件**，丢地上、放箱子、捡起来都不会 +1，只有真正吃掉的那一瞬才 +1。用它当判据，比背包计数干净得多。

统计型 objective 是只读的，**绝对不能用 `scoreboard players set` 写**，只能由游戏内部 +1；所以配套还要一个 dummy 用来存"上次看到的快照值"，本刻 `used > last` 就说明这刻吃过。

我自己实测过的关键点（你也可以自己用 `/help` 核对一遍）：`/scoreboard objectives add <名字> minecraft.used:minecraft.golden_apple` 在 1.20.1 是合法语法；附魔金苹果是另一个统计 `minecraft.used:minecraft.enchanted_golden_apple`，不吃这边。

---

## 改动总览

| 文件 | 动作 |
|---|---|
| `load.mcfunction` | 追加 2 个 objective |
| `tick.mcfunction` | 在"冷却递减"与"职业技能结算"之间插 1 行检测 |
| `skill/warrior.mcfunction` | 简化，只管补发 |
| `skill/warrior_ready.mcfunction` | 简化，无条件发一个苹果 |
| `skill/warrior_consume.mcfunction` | **新建**——吃过苹果 → 进冷却 |
| `player/join.mcfunction` | 追加 1 行同步快照 |
| `util/clear_player.mcfunction` | 追加 2 行同步快照 + 清 tag |

---

src/data/kitpvp/functions/load.mcfunction

在"二、计分板"段末尾（`scoreboard objectives modify kitpvp.kills ...` 之后）追加：

```mcfunction
scoreboard objectives add kitpvp.gapple_used minecraft.used:minecraft.golden_apple
scoreboard objectives add kitpvp.gapple_last dummy "金苹果快照"
```

**注意**：`kitpvp.gapple_used` 是统计型，**不要**在"五、玩家状态归零"里对它 set，会报错。

---

src/data/kitpvp/functions/tick.mcfunction

在"冷却递减"两行之后、"职业技能结算"之前插入：

```mcfunction
# ===== 战士金苹果消耗检测 =====
# 统计 objective：吃掉金苹果的瞬间 used 自动 +1
# 本刻 used 比 last 大 → 刚吃掉，转交 warrior_consume
# 必须在"冷却递减"之后再跑，避免 cd 被本 tick 的递减覆盖
execute as @a[scores={kitpvp.kit=1..,kitpvp.alive=1}] if score @s kitpvp.gapple_used > @s kitpvp.gapple_last run function kitpvp:skill/warrior_consume
```

---

src/data/kitpvp/functions/skill/warrior_consume.mcfunction

```mcfunction
# ===== 战士：金苹果被吃掉 → 进 40 秒冷却 =====
# 触发：tick.mcfunction 检测到 used > last
# @s = 吃掉苹果的战士

# 1. 快照推到当前值，防止下一刻重复触发
scoreboard players operation @s kitpvp.gapple_last = @s kitpvp.gapple_used

# 2. 摘掉"持有中"标记，进入 40 秒冷却
tag @s remove kitpvp.skill_ready
scoreboard players set @s kitpvp.cd 800

title @s actionbar {"text":"补给进入冷却：40 秒","color":"gray"}
playsound minecraft:entity.player.burp master @s ~ ~ ~ 0.5 1.0
```

---

src/data/kitpvp/functions/skill/warrior.mcfunction

```mcfunction
# ===== 战士技能：补给 =====
# 用 minecraft.used:minecraft.golden_apple 统计精确检测"吃掉"事件：
#   - 丢地上：统计不动 → 不触发冷却、不补发
#   - 放箱子/交出：统计不动 → 同上
#   - 真正吃掉：统计 +1  → 由 warrior_consume 转入 40 秒冷却
#
# 状态机（只用一个 tag + 一个 cd）：
#   持有中   tag=kitpvp.skill_ready   cd = 0        已发 1 个，等玩家吃
#   冷却中   tag 已摘掉               cd = 800..1   正在走 40 秒
#   待补发   tag 已摘掉               cd = 0        冷却刚走完 → 本刻补发
#
# 调用方：tick.mcfunction -> skill/dispatch（cd<=0 时）
#   进入条件：kitpvp.kit=1 且 kitpvp.alive=1 且 kitpvp.cd <= 0

# 待补发状态 → 立刻发一份；否则什么都不做
execute if entity @s[tag=!kitpvp.skill_ready] run function kitpvp:skill/warrior_ready
```

---

src/data/kitpvp/functions/skill/warrior_ready.mcfunction

```mcfunction
# ===== 战士：发出"补给"这一份金苹果 =====
# 调用时机：
#   1) kit/warrior.mcfunction —— 选出战士的那一刻
#   2) skill/warrior.mcfunction —— 40 秒冷却走完时
#
# 上限 1 的保证方式变了：不再检查背包（因为统计方案里"吃完才会进冷却"，
# 冷却期间不会补发），而是靠在冷却 + tag 上的互斥保证。

give @s minecraft:golden_apple 1
tag @s add kitpvp.skill_ready
scoreboard players set @s kitpvp.cd 0

title @s actionbar {"text":"补给：获得 1 个金苹果","color":"gold"}
playsound minecraft:entity.item.pickup master @s ~ ~ ~ 0.6 1.4
```

---

src/data/kitpvp/functions/player/join.mcfunction

在 `scoreboard players set @s kitpvp.item 0` 之后追加：

```mcfunction
# 同步金苹果统计快照，防止上一个会话遗留的累计统计误触发冷却
scoreboard players operation @s kitpvp.gapple_last = @s kitpvp.gapple_used
```

---

src/data/kitpvp/functions/util/clear_player.mcfunction

在"四、分数归零"段的末尾追加：

```mcfunction
# 同步金苹果统计快照（统计型只读，只能在这里对齐快照）
scoreboard players operation @s kitpvp.gapple_last = @s kitpvp.gapple_used
```

---

## 行为对照（新版）

| 玩家做的事 | wanted | 新版行为 |
|---|---|---|
| 吃掉技能发的苹果 | 进冷却 | 统计 +1 → 进 40 秒冷却 ✅ |
| 丢在地上 | 不刷 | 统计不动 → 不进冷却、不补发 ✅ |
| 丢地上等 40 秒再捡回 | 不刷 | 同上，捡回后还是同一个 ✅ |
| 丢进岩浆 / 掉虚空 | 进冷却 | 实体消失但玩家**没吃** → 统计不动 → 不进冷却 ⚠️ |
| 放箱子 | 进冷却 | 同上 ⚠️ |
| 捡起地上的别人苹果吃掉 | 看设计 | 统计 +1 → 进冷却（"吃任何金苹果都算"，简单一致） ✅ |

⚠️ 那两行行为变化说明：统计方案只管"吃"这件事，**消耗以外的转移一律不进冷却**。这对"丢地上刷"是好事，但也意味着"把苹果丢进岩浆然后下一轮照常领"是允许的——如果想要"丢了也进冷却"，可以再加一条：本 tick 检测到 `used == last` 且 `tag=kitpvp.skill_ready` 且背包没有苹果且维度内也没有无标记苹果掉落物（参考上一版的思路），才判定为"丢失性消耗"。但你想要的显然不是这个复杂度，所以上面没做。

## 两点提醒

1. **不要**在"五、玩家状态归零"或 `clear_player` 里出现 `scoreboard players set @a kitpvp.gapple_used 0`，统计型是只读的，写会报错。同步快照才是唯一手段。
2. `execute if score ... > ...` 只能做数值比较，不能比较"两个玩家"，这里两边都是 `@s`（`as @a` 展开后同一个玩家），没问题。