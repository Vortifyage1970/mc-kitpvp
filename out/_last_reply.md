战士技能（自动「补给」）已确认要删掉，改为「选职业时直接给 2 个金苹果」。下面按文件给出改动。

---

## 一、改动总览

| 文件 | 动作 |
|---|---|
| `skill/warrior.mcfunction` | 清空为占位（原补给状态机） |
| `skill/warrior_consume.mcfunction` | 清空为占位 |
| `skill/warrior_ready.mcfunction` | 清空为占位 |
| `tick.mcfunction` | 删除「战士金苹果消耗检测」整段 |
| `load.mcfunction` | 删除 `gapple_used` / `gapple_last` 两个 objective |
| `util/clear_player.mcfunction` | 删除 `gapple_last` 快照行 |

我选「留空占位」而不是「直接删文件」：这样即使你暂时没改 `skill/dispatch`，也不会出现「调用不存在的函数」报错刷屏。想彻底删文件，见文末「三、可选清理」。

---

## 二、文件内容

`src/data/kitpvp/functions/skill/warrior.mcfunction`

```mcfunction
# ===== 战士技能：已删除 =====
# 战士改为"选择职业时直接给 2 个金苹果"，不再有自动补给技能。
# 本文件保留为空函数，只为兼容 skill/dispatch.mcfunction 中 kit=1 的调用行。
# 若已同步删除 dispatch 里 kit=1 那一行，可直接删除本文件。
```

`src/data/kitpvp/functions/skill/warrior_consume.mcfunction`

```mcfunction
# ===== 战士：已删除 =====
# 原"金苹果被吃掉 → 进 40 秒冷却"逻辑随战士技能一并移除。
# tick.mcfunction 里的 gapple_used 检测行已删，本文件不再被任何地方调用。
# 可直接删除本文件。
```

`src/data/kitpvp/functions/skill/warrior_ready.mcfunction`

```mcfunction
# ===== 战士：已删除 =====
# 原"发放补给金苹果"逻辑随战士技能一并移除。
# 若 kit/warrior.mcfunction 里仍有 function kitpvp:skill/warrior_ready 调用行，请一并删除。
# 可直接删除本文件。
```

`src/data/kitpvp/functions/tick.mcfunction`

```mcfunction
# 每游戏刻执行
# 玩家接入检测：未登记的玩家 → 走 join 流程
execute as @a[tag=!kitpvp.joined] run function kitpvp:player/join

# 冷却递减
execute as @a[scores={kitpvp.cd=1..}] run scoreboard players remove @s kitpvp.cd 1
execute as @a[scores={kitpvp.cd2=1..}] run scoreboard players remove @s kitpvp.cd2 1

# ===== 主大厅：兜底补发大厅物品 =====
# 场景一：玩家选职业时 clear_player 清空背包，但人还在大厅（in_lobby 不清），
#         这段每刻检测，缺钓竿或缺大厅剑就补回。
# 场景二：玩家把物品丢地上，下一刻也会补一份（不阻塞玩法）。
# 幂等由 give_items 内部 Inventory 检测保证，不会重复堆叠。
# 只动 tag=kitpvp.in_lobby 的玩家，局内玩家不受影响。
execute as @a[tag=kitpvp.in_lobby,tag=!kitpvp.spectator] run function kitpvp:lobby/give_items

# ===== 主大厅：补充饱食度 =====
execute as @a[tag=kitpvp.in_lobby,tag=!kitpvp.spectator] run effect give @s minecraft:saturation 1 1 true

# ===== 主大厅：传送执行 =====
execute as @a[tag=kitpvp.in_lobby,tag=!kitpvp.spectator] at @s run function kitpvp:lobby/teleport

# ==== 主大厅：显示锁定 =====
function kitpvp:lobby/display_lock

# ===== 主大厅：踩压力板弹出职业介绍 =====
# 只动 tag=kitpvp.in_lobby 的玩家；防重复逻辑在 lobby/pad 内部
function kitpvp:lobby/pad

# ===== 主大厅：准备 / 取消准备（右键准备钓竿）=====
# 统计 objective：右键胡萝卜钓竿的瞬间 used 自动 +1
# ready_last 快照在 lobby/enter 里被推到当前值，
# 保证"进大厅之前"的历史右键不会在进大厅那一刻被误判
execute as @a[tag=kitpvp.in_lobby,tag=!kitpvp.spectator] if score @s kitpvp.ready_used > @s kitpvp.ready_last run function kitpvp:lobby/ready_toggle

# ===== 坦克蛋：令牌 / 魂石 共用 iron_golem_spawn_egg，靠 CustomName 分流 =====
# 去掉 kit=3 限制：坦克魂石是通用奖励，任何职业捡到都能用
# 分流在 tank_dispatch 内部：举盾令牌只对坦克本人且 cd 归零时生效
execute as @a[tag=kitpvp.selected,scores={kitpvp.alive=1},tag=!kitpvp.spectator] if score @s kitpvp.tank_used > @s kitpvp.tank_last run function kitpvp:skill/tank_dispatch

# ===== 坦克：护盾 15 秒到期 =====
# cd 记 600（30 秒）：前 300 刻持盾，后 300 刻纯冷却。
# 用 ..300（不是精确 =300）：即使服务端卡顿跳过某刻，也会被下一轮捕捉，不漏。
# tag=kitpvp.shield_held 保证每个盾只会被清一次，不会重复触发。
# 必须排在"坦克使用检测"之后：否则坦克刚给盾（cd=600），本行同一刻就可能被算进去。
execute as @a[scores={kitpvp.cd=..300},tag=kitpvp.shield_held,tag=!kitpvp.spectator] run function kitpvp:skill/tank_expire

# ===== 坦克：清除令牌生成的铁傀儡 =====
# 令牌是铁傀儡刷怪蛋，右键会在玩家附近生成一只铁傀儡。
# 本行把它立刻清掉：只保留"按下右键"这个信号，不留残局生物。
# distance=..16 覆盖刷怪蛋的最大右键射程（约 4.5 格），
# 且避免误杀远处其它来源的铁傀儡。
# ⚠ 若某张地图自带装饰性铁傀儡且落在坦克 16 格内，会被一并清掉。
execute as @a[scores={kitpvp.kit=3}] at @s run kill @e[type=iron_golem,distance=..16,name="举盾令牌"]

# ===== 坦克：举盾令牌兜底补发 =====
# 冷却结束、背包里又没有令牌时，补发一个，让坦克能继续施法
# 判据：Inventory 里存在任一带 KitTankEgg:1b 标记的物品
# 玩家"丢令牌"会形成物品堆积，但每个令牌只相当于一次技能使用，不放大技能次数
execute as @a[scores={kitpvp.kit=3,kitpvp.alive=1,kitpvp.cd=0},tag=!kitpvp.spectator] unless data entity @s Inventory[{tag:{KitTankEgg:1b}}] run function kitpvp:skill/tank_give_egg

# ===== 弓箭手：清除落地的箭 =====
# 弓箭手射出的箭一落地（inGround:1b）就清除，
# 防止"射出去 → 换弹 → 再捡回来"把箭数刷过 12 支上限。
# 副作用：会一并清掉其它来源（如骷髅）落地的箭。
kill @e[type=minecraft:arrow,nbt={inGround:1b}]

# ===== 刺客蛋：令牌 / 魂石 共用 enderman_spawn_egg，靠 CustomName 分流 =====
execute as @a[tag=kitpvp.selected,scores={kitpvp.alive=1},tag=!kitpvp.spectator] if score @s kitpvp.assassin_used > @s kitpvp.assassin_last run function kitpvp:skill/assassin_dispatch

# ===== 刺客：隐匿 5 秒到期 =====
# cd 记 600（30 秒）：前 100 刻隐身+速度 III，后 500 刻纯冷却。
# 用 ..500（不是精确 =500）：即使服务端卡顿跳过某刻，也会被下一轮捕捉，不漏。
# tag=kitpvp.assassin_hidden 保证每次隐匿只触发一次，不会重复挂效果。
execute as @a[scores={kitpvp.cd=..500},tag=kitpvp.assassin_hidden,tag=!kitpvp.spectator] run function kitpvp:skill/assassin_unhide

# ===== 刺客：清除令牌生成的末影人 =====
# 令牌是末影人刷怪蛋，右键会在玩家附近生成一只末影人。
# 本行把它立刻清掉：只保留"按下右键"这个信号，不留残局生物。
# distance=..16 覆盖刷怪蛋的最大右键射程（约 4.5 格），
# 且避免误杀远处其它来源的末影人。
# ⚠ 若某张地图自带装饰性末影人且落在刺客 16 格内，会被一并清掉。
execute as @a[scores={kitpvp.kit=4}] at @s run kill @e[type=enderman,distance=..16,name="隐匿令牌"]

# ===== 刺客：隐匿令牌兜底补发 =====
# 冷却结束、背包里又没有令牌时，补发一个，让刺客能继续施法
# 判据：Inventory 里存在任一带 KitAssassinEgg:1b 标记的物品
execute as @a[scores={kitpvp.kit=4,kitpvp.alive=1,kitpvp.cd=0},tag=!kitpvp.spectator] unless data entity @s Inventory[{tag:{KitAssassinEgg:1b}}] run function kitpvp:skill/assassin_give_item

# ===== 魂石：战士（blaze_spawn_egg 专用）=====
execute as @a[tag=kitpvp.selected,scores={kitpvp.alive=1},tag=!kitpvp.spectator] if score @s kitpvp.soul_warrior_used > @s kitpvp.soul_warrior_last run function kitpvp:skill/soul/use_warrior

# ===== 魂石：弓箭手（skeleton_spawn_egg 专用）=====
execute as @a[tag=kitpvp.selected,scores={kitpvp.alive=1},tag=!kitpvp.spectator] if score @s kitpvp.soul_archer_used > @s kitpvp.soul_archer_last run function kitpvp:skill/soul/use_archer

# ===== 职业技能结算（统一入口）=====
# 只筛"有职业、活着、主技能冷却归零"的玩家，转交 dispatch；
# 具体哪个职业发什么，由 skill/dispatch 按 kitpvp.kit 分派。
# 新增自动技能请改 skill/dispatch，不要在这里加行。
# 主动技能不经过本行——它们由各自的触发器接（参见坦克）。
execute as @a[scores={kitpvp.kit=1..,kitpvp.alive=1}] if score @s kitpvp.cd matches ..0 run function kitpvp:skill/dispatch

# ===== 魂石之弓：20 秒到期 =====
execute as @a[tag=kitpvp.soul_bow_held,scores={kitpvp.soul_bow_timer=1..}] run scoreboard players remove @s kitpvp.soul_bow_timer 1
execute as @a[tag=kitpvp.soul_bow_held,scores={kitpvp.soul_bow_timer=..0}] run function kitpvp:skill/soul/bow_expire

# 兼容中途加入的玩家：没有 inv 分数就补 0
scoreboard players add @a kitpvp.inv 0

# 无敌倒计时（每刻 -1）
execute as @a[scores={kitpvp.inv=1..}] run scoreboard players remove @s kitpvp.inv 1

# 无敌结束
execute as @a[tag=kitpvp.invincible,scores={kitpvp.inv=0}] run function kitpvp:player/end_invincible

# 虚空兜底：Y < -74 直接判死（阈值可调）
# y=-1024 配合 dy=950 覆盖 y ∈ [-1024, -74]
execute as @a[tag=kitpvp.selected,tag=!kitpvp.spectator,gamemode=!spectator] if entity @s[y=-1024,dy=950] run damage @s 1000 minecraft:out_of_world

# 死亡检测
execute as @a[tag=!kitpvp.spectator,tag=!kitpvp.respawn_pending] if score @s kitpvp.death_detect > @s kitpvp.death_seen run function kitpvp:player/death_dispatch

# 重生后处理（由 on_death 打 tag，本 tick 消费）
execute as @a[tag=kitpvp.respawn_pending,tag=!kitpvp.spectator] run function kitpvp:player/after_death

# ===== 胜负兜底轮询（每 20 刻一次）=====
# 覆盖"玩家中途退出服务器导致幸存者减少，但没人触发 eliminate"的情况
scoreboard players add #tick kitpvp.game 1
execute if score #tick kitpvp.game matches 20.. run scoreboard players set #tick kitpvp.game 0
execute if score #tick kitpvp.game matches 0 if score #state kitpvp.game matches 1 run function kitpvp:game/check_winner
```

`src/data/kitpvp/functions/load.mcfunction`

```mcfunction
# 数据包加载时执行一次
# 一、游戏规则
gamerule keepInventory true
gamerule doMobSpawning false
gamerule mobGriefing false
gamerule doFireTick false
gamerule doInsomnia false
gamerule doWeatherCycle false
gamerule naturalRegeneration true
gamerule fallDamage true
gamerule announceAdvancements false
gamerule doImmediateRespawn true
gamerule logAdminCommands false
gamerule commandBlockOutput false
#gamerule sendCommandFeedback false

# 二、计分板
scoreboard objectives add kitpvp.kit dummy "职业"
scoreboard objectives add kitpvp.cd dummy "技能冷却"
scoreboard objectives add kitpvp.cd2 dummy "第二技能冷却"
scoreboard objectives add kitpvp.alive dummy "存活"
scoreboard objectives add kitpvp.lives dummy "命数"
scoreboard objectives add kitpvp.kills dummy "击杀数"
scoreboard objectives add kitpvp.deaths dummy "死亡数"
scoreboard objectives add kitpvp.map dummy "地图"
scoreboard objectives add kitpvp.timer dummy "倒计时"
scoreboard objectives add kitpvp.inv dummy
scoreboard objectives add kitpvp.death_detect deathCount
scoreboard objectives add kitpvp.death_seen dummy
scoreboard objectives add kitpvp.game dummy "游戏状态"
scoreboard objectives add kitpvp.item dummy "物品计数"
scoreboard objectives add kitpvp.tank_used minecraft.used:minecraft.iron_golem_spawn_egg
scoreboard objectives add kitpvp.tank_last dummy "坦克技能快照"
scoreboard objectives add kitpvp.assassin_used minecraft.used:minecraft.enderman_spawn_egg
scoreboard objectives add kitpvp.assassin_last dummy "刺客技能快照"
scoreboard objectives add kitpvp.ready_used minecraft.used:minecraft.carrot_on_a_stick
scoreboard objectives add kitpvp.ready_last dummy "大厅准备快照"
scoreboard objectives add kitpvp.tmp dummy
scoreboard objectives add kitpvp.soul_rand dummy "魂石随机数"
scoreboard objectives add kitpvp.soul_bow_timer dummy "魂石弓倒计时"
scoreboard objectives add kitpvp.soul_warrior_used minecraft.used:minecraft.blaze_spawn_egg
scoreboard objectives add kitpvp.soul_archer_used minecraft.used:minecraft.skeleton_spawn_egg
scoreboard objectives add kitpvp.soul_warrior_last dummy "战士魂石快照"
scoreboard objectives add kitpvp.soul_archer_last dummy "弓箭手魂石快照"

scoreboard objectives modify kitpvp.kit displayname {"text":"职业","color":"gold"}
scoreboard objectives modify kitpvp.lives displayname {"text":"命数","color":"red"}
scoreboard objectives modify kitpvp.kills displayname {"text":"击杀","color":"aqua"}

scoreboard objectives setdisplay sidebar kitpvp.lives

# 三、队伍
# 设计文档 2.8：无阵营，所有人互为敌人，此处不创建红/蓝阵营队伍。
# 若后续某张地图需要队伍机制，在此追加 team add / team modify。

# 四、标签清理
tag @a remove kitpvp.selected
tag @a remove kitpvp.invincible
tag @a remove kitpvp.sudden_death
tag @a remove kitpvp.in_lobby
tag @a remove kitpvp.spectator
tag @a remove kitpvp.death_immune
tag @a remove kitpvp.keep_inventory
tag @a remove kitpvp.respawn_pending
tag @a remove kitpvp.joined
tag @a remove kitpvp.skill_ready
tag @a remove kitpvp.skill_consume
tag @a remove kitpvp.shield_held
tag @a remove kitpvp.assassin_hidden
tag @a remove kitpvp.soul_bow_held
tag @a remove kitpvp.soul_transit
tag @a remove kitpvp.on_pad

# 五、玩家状态归零
scoreboard players set @a kitpvp.kit 0
scoreboard players set @a kitpvp.cd 0
scoreboard players set @a kitpvp.cd2 0
scoreboard players set @a kitpvp.alive 1
scoreboard players set @a kitpvp.lives 3
scoreboard players set @a kitpvp.kills 0
scoreboard players set @a kitpvp.deaths 0
scoreboard players set @a kitpvp.inv 0
scoreboard players set @a kitpvp.death_detect 0
scoreboard players set @a kitpvp.death_seen 0
scoreboard players set @a kitpvp.item 0

# 六、全局假玩家数据
scoreboard players set #global kitpvp.map 0
scoreboard players set #global kitpvp.timer 0
scoreboard players set #state kitpvp.game 0
scoreboard players set #survivors kitpvp.game 0
scoreboard players set #tick kitpvp.game 0
scoreboard players set #test kitpvp.game 0
scoreboard players set #soul_count kitpvp.game 4

# 七、清空 storage
data remove storage kitpvp:main temp
data remove storage kitpvp:main player

# 八、给所有盔甲架和物品框加上标签
tag @e[type=minecraft:armor_stand] add kitpvp.displayitem
tag @e[type=minecraft:item_frame] add kitpvp.displayitem
tag @e[type=minecraft:glow_item_frame] add kitpvp.displayitem

execute as @e[tag=kitpvp.displayitem] run data merge entity @s {Invulnerable:1b}

say Kitpvp loaded
```

`src/data/kitpvp/functions/util/clear_player.mcfunction`

```mcfunction
# ===== 将 @s 清到"干净初始状态" =====
# 复用方：
#   1) 选职业（每个职业函数的第一行）
#   2) 主大厅 [初始化我] 按钮 -> kitpvp:lobby/reset_self
#   3) 结算重置 -> execute as @a run function kitpvp:util/clear_player
#
# 约定：本函数会清掉 kitpvp.kit。
# 这不是 bug——选职业入口是"具体职业函数"，函数自己知道要写成几号，
# 所以清完立刻由职业函数写回。不存在"待选 id 丢失"的问题。
#
# 保留的会话性 tag（刻意不清）：
#   kitpvp.joined    清了会导致根 tick 重复触发 player/join
#   kitpvp.in_lobby  位置状态；on_death 用它判定"大厅死亡不计"
#
# 本函数不负责：
#   位置 / 传送        由调用方负责
#   spawnpoint         由 game/start 或 map/distribute 写入
#   着火状态           1.20.1 无 /extinguish（该命令 1.20.5 才有）
#   饱食度 / 饱和度    1.20.1 无直接命令可复位

# --- 一、背包 / 效果 / 经验 ---
clear @s
effect clear @s
xp set @s 0 points
xp set @s 0 levels

# --- 二、下坐骑 ---
ride @s dismount

# --- 三、游戏性 tag 清理 ---
tag @s remove kitpvp.selected
tag @s remove kitpvp.invincible
tag @s remove kitpvp.sudden_death
tag @s remove kitpvp.spectator
tag @s remove kitpvp.respawn_pending
tag @s remove kitpvp.death_immune
tag @s remove kitpvp.keep_inventory
tag @s remove kitpvp.skill_ready
tag @s remove kitpvp.skill_consume
tag @s remove kitpvp.shield_held
tag @s remove kitpvp.assassin_hidden
tag @s remove kitpvp.ready
tag @s remove kitpvp.ready_pending

# --- 四、分数归零（含 kit）---
scoreboard players set @s kitpvp.kit 0
scoreboard players set @s kitpvp.cd 0
scoreboard players set @s kitpvp.cd2 0
scoreboard players set @s kitpvp.inv 0
scoreboard players operation @s kitpvp.death_seen = @s kitpvp.death_detect
scoreboard players set @s kitpvp.item 0
scoreboard players set @s kitpvp.lives 3
scoreboard players set @s kitpvp.kills 0
scoreboard players set @s kitpvp.deaths 0
scoreboard players set @s kitpvp.alive 1
# 坦克统计快照：清场时把 last 推到 used，避免清场后下一刻误判
scoreboard players operation @s kitpvp.tank_last = @s kitpvp.tank_used
scoreboard players operation @s kitpvp.assassin_last = @s kitpvp.assassin_used
# 主大厅准备钓竿快照：同上
scoreboard players operation @s kitpvp.ready_last = @s kitpvp.ready_used
scoreboard players set @s kitpvp.soul_rand 0
scoreboard players set @s kitpvp.soul_bow_timer 0
scoreboard players operation @s kitpvp.soul_warrior_last = @s kitpvp.soul_warrior_used
scoreboard players operation @s kitpvp.soul_archer_last = @s kitpvp.soul_archer_used
tag @s remove kitpvp.soul_bow_held

# --- 五、属性复位到原版默认 ---
attribute @s minecraft:generic.max_health base set 20
attribute @s minecraft:generic.movement_speed base set 0.1
attribute @s minecraft:generic.attack_damage base set 1
attribute @s minecraft:generic.attack_speed base set 4
attribute @s minecraft:generic.knockback_resistance base set 0
attribute @s minecraft:generic.armor base set 0
attribute @s minecraft:generic.armor_toughness base set 0

# --- 六、回大厅模式 + 回满血 ---
gamemode adventure @s
# 1.20.1 无 /heal，用 instant_health 代替，足以回满
effect give @s minecraft:instant_health 1 5 true
```

---

## 三、你必须自己补齐的三处（本次上下文里没有这些文件的正文）

### 1. `src/data/kitpvp/functions/skill/dispatch.mcfunction`

删除这一行（战士已无自动技能）：

```
execute if score @s kitpvp.kit matches 1 run function kitpvp:skill/warrior
```

### 2. `src/data/kitpvp/functions/kit/warrior.mcfunction`

**这个文件没在本次上下文里，请贴出原文我再给完整版。** 需要做两件事：

- 如果里面有 `function kitpvp:skill/warrior_ready` 这一行 → 删掉；
- 在 `clear_player` 之后、装备发放之后的合适位置，加这一行：

```mcfunction
give @s minecraft:golden_apple 2
```

（注意：`kit/warrior` 第一行是 `function kitpvp:util/clear_player`，它会 `clear @s` 清空背包，所以金苹果必须写在它**之后**，否则会被清掉。）

### 3. `src/data/kitpvp/functions/player/join.mcfunction`

按 `04-hazards-reminder.md` 第四节，`gapple_last` 的初始快照在 `join` 里也有一行。objective 已不创建，这一行必须删掉，否则新玩家进服时该行会报错：

```
scoreboard players operation @s kitpvp.gapple_last = @s kitpvp.gapple_used
```

**请贴出 `player/join.mcfunction` 原文确认。**

---

## 四、可选清理

### 彻底删文件

若你已按上面第 1 条删掉 `dispatch` 里 kit=1 那行、并确认 `kit/warrior` 里没有 `function kitpvp:skill/warrior_ready`，则可以直接删除这三个文件，不用留占位：

- `skill/warrior.mcfunction`
- `skill/warrior_consume.mcfunction`
- `skill/warrior_ready.mcfunction`

### 旧存档残留的 objective

`kitpvp.gapple_used` / `kitpvp.gapple_last` 在已经加载过的世界里仍会存在，不影响运行（没有任何地方再读写它们）。要清掉就手动执行一次：

```
/scoreboard objectives remove kitpvp.gapple_used
/scoreboard objectives remove kitpvp.gapple_last
```

**不要**把这两行写进 `load.mcfunction`：对已不存在的 objective 执行 `remove` 的行为我不确定是否静默，请先 `/help scoreboard` 或实测确认再决定。放在 `load` 里若报错，每次加载都会刷一次日志。

### 同步更新文档

- `01-file-structure.md`：删掉那三个文件（或保留，取决于你是否真删）
- `03-project-spec.md` 六、计分板登记表：删掉 `kitpvp.gapple_used` / `kitpvp.gapple_last` 两行，并注明战士改为「选择时给 2 个金苹果」
- `03-project-spec.md` 九·五：战士的「技能类型」由「自动」改为「无（选择时给物品）」
- `04-hazards-reminder.md` 第四节：该节以战士为参照实现，若要保留作为"反面教材/历史记录"，请在该节顶部加一句「参照实现已删除」；否则整节可精简