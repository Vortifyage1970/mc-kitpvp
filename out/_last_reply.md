好，两点都收到：

1. 触发物改用**刷怪蛋**（坦克默认用 `iron_golem_spawn_egg`，铁傀儡刷怪蛋——灰白色，最贴"铁甲肉盾"）。生成的铁傀儡由 tick 立刻 `kill`。
2. **冷却从给盾一瞬间开始**：`tank_fire` 的最后一步才 `set cd 600`。

**上一轮我给出的 `advancements/player/tank_cast.json` 请直接不要创建；如果你已经建了，删掉它。** 这一版不再用 advancement，改走"统计 objective 检测刷怪蛋被使用"的路线——和战士金苹果同一套模式，最稳。

下面给出完整最终版。**新增 7 个文件、改动 9 个文件。**

---

## 一、新增文件

### 1. 职业发放入口

文件路径：`src\data\kitpvp\functions\kit\tank.mcfunction`

```mcfunction
# ===== 坦克（kit id = 3）=====
# 入口：/function kitpvp:kit/tank
# 顺序不可调：先清场（clear_player 会把 kit 归零），再写回本职业 id，最后发装备

# --- 头三行：每个职业函数完全一致，只改数字 ---
function kitpvp:util/clear_player
scoreboard players set @s kitpvp.kit 3
tag @s add kitpvp.selected

# --- 本职业配置 ---
scoreboard players set @s kitpvp.alive 1
scoreboard players set @s kitpvp.lives 3

attribute @s minecraft:generic.max_health base set 20
attribute @s minecraft:generic.movement_speed base set 0.1

item replace entity @s armor.head with minecraft:diamond_helmet{Unbreakable:1b}
item replace entity @s armor.chest with minecraft:diamond_chestplate{Unbreakable:1b}
item replace entity @s armor.legs with minecraft:diamond_leggings{Unbreakable:1b}
item replace entity @s armor.feet with minecraft:diamond_boots{Unbreakable:1b}
item replace entity @s hotbar.0 with minecraft:wooden_sword{Unbreakable:1b}
item replace entity @s hotbar.1 with minecraft:cooked_beef 16

# 永久被动：缓慢 I + 挖掘疲劳 I
function kitpvp:kit/tank_passive

# 主动技能令牌：右键投出"举盾"（铁傀儡刷怪蛋）
function kitpvp:skill/tank_give_egg

tellraw @s [{"text":"[已选择] ","color":"green","bold":true},{"text":"坦克","color":"yellow","bold":true},{"text":"  右键","color":"gray"},{"text":"举盾令牌","color":"aqua","bold":true},{"text":"释放技能","color":"gray"}]
```

---

### 2. 永久被动

文件路径：`src\data\kitpvp\functions\kit\tank_passive.mcfunction`

```mcfunction
# ===== 坦克：永久被动效果 =====
# 死亡会清空玩家的全部药水效果，重生后需要重新挂上
# 调用方：
#   kit/tank              （选职业时）
#   player/after_death    （重生之后）
#
# ⚠ 1.20.1 没有"无限时长效果"，infinite 关键字是 1.20.2+ 才有。
#   用 999999 秒近似（≈11.5 天，长于一局比赛）。
#   amplifier 0 = I 级；true = 隐藏粒子

effect give @s minecraft:mining_fatigue 999999 0 true
effect give @s minecraft:slowness 999999 0 true
```

---

### 3. 职业介绍卡片

文件路径：`src\data\kitpvp\functions\kit\info\tank.mcfunction`

```mcfunction
# ===== 坦克 · 职业介绍卡片 =====
# 由 kit/list/classic 里点击坦克条目时调用，@s = 查看者

tellraw @s [{"text":"┌──────────────────────────────","color":"dark_gray"}]
tellraw @s [{"text":"│ 职业名：","color":"gray"},{"text":"坦克","color":"yellow","bold":true}]
tellraw @s [{"text":"│ 分类：","color":"gray"},{"text":"经典（表）","color":"white"}]
tellraw @s [{"text":"│ 简介：","color":"gray"},{"text":"高护甲低速的肉盾","color":"white"}]
tellraw @s [{"text":"│ 武器单次伤害：","color":"gray"},{"text":"4","color":"white"}]
tellraw @s [{"text":"│ 武器攻击速度：","color":"gray"},{"text":"1.6","color":"white"}]
tellraw @s [{"text":"│ 总护甲值：","color":"gray"},{"text":"20","color":"white"}]
tellraw @s [{"text":"│ 总护甲韧性：","color":"gray"},{"text":"8","color":"white"}]
tellraw @s [{"text":"│ 被动：","color":"gray"},{"text":"缓慢 I、挖掘疲劳 I","color":"yellow"}]
tellraw @s [{"text":"│ 技能：","color":"gray"},{"text":"举盾","color":"yellow"},{"text":" —— 右键\"举盾令牌\"，获得 1 个持续 15 秒、剩余耐久 80 的盾","color":"white"}]
tellraw @s [{"text":"│ 技能冷却：","color":"gray"},{"text":"30 秒（从给盾一瞬间起算）","color":"white"}]
tellraw @s [{"text":"└──────────────────────────────","color":"dark_gray"}]
tellraw @s [{"text":"[ 确认选择 ]","color":"green","bold":true,"clickEvent":{"action":"run_command","value":"/function kitpvp:kit/tank"},"hoverEvent":{"action":"show_text","contents":[{"text":"以坦克参战","color":"gray"}]}},{"text":" "},{"text":"[ 返回 ]","color":"yellow","clickEvent":{"action":"run_command","value":"/function kitpvp:lobby/menu"},"hoverEvent":{"action":"show_text","contents":[{"text":"回到主大厅菜单","color":"gray"}]}}]
```

---

### 4. 发放令牌

文件路径：`src\data\kitpvp\functions\skill\tank_give_egg.mcfunction`

```mcfunction
# ===== 坦克：发放"举盾令牌"（铁傀儡刷怪蛋） =====
# 调用方：
#   kit/tank            （选职业时）
#   tick.mcfunction     （令牌被用掉 / 丢失后的兜底补发）
#   player/after_death  （重生后清理）
#
# 令牌物品：minecraft:iron_golem_spawn_egg，带 KitTankEgg:1b 标记
#   - 右键会生成一只铁傀儡（原版行为），并让 minecraft.used 统计 +1
#   - 生成的铁傀儡由 tick 立刻 kill 掉，不会留场
#   - 令牌没有其它效果，右键不消耗 CD 之外的东西
#
# 幂等：已经持有令牌时不再重复发放
# 判据：Inventory 数组里存在任一带 KitTankEgg:1b 标记的物品

execute unless data entity @s Inventory[{tag:{KitTankEgg:1b}}] run give @s minecraft:iron_golem_spawn_egg{KitTankEgg:1b,display:{Name:'{"text":"举盾令牌","color":"aqua","bold":true}'}} 1
```

---

### 5. 主动技能入口

文件路径：`src\data\kitpvp\functions\skill\tank_cast.mcfunction`

```mcfunction
# ===== 坦克：举盾（主动技能入口） =====
# 触发：tick.mcfunction 检测到"刚用掉一个举盾令牌"
#       判据：kitpvp.tank_used > kitpvp.tank_last
# @s = 坦克
#
# 流程：
#   1. 推进快照，防止下一刻重复触发（漏写会造成无限连放）
#   2. cd <= 0 → 转交 skill/tank_fire 给盾、进冷却
#   3. cd > 0  → 冷却中，仅提示
#      极少数情况能走到这里：玩家捡起了自己/别人丢在地上的旧令牌又右键。
#      这种情况下令牌已消耗、技能不放，属于设计接受的惩罚。

scoreboard players operation @s kitpvp.tank_last = @s kitpvp.tank_used

execute if score @s kitpvp.cd matches ..0 run function kitpvp:skill/tank_fire
execute if score @s kitpvp.cd matches 1.. run title @s actionbar {"text":"举盾冷却中","color":"gray"}
```

---

### 6. 给盾 + 进冷却

文件路径：`src\data\kitpvp\functions\skill\tank_fire.mcfunction`

```mcfunction
# ===== 坦克：给盾 + 进入冷却 =====
# 调用：skill/tank_cast（玩家右键令牌，cd 归零时）
# @s = 坦克
#
# 冷却从"给盾一瞬间"开始：
#   set cd 600 是本函数的最后一步，从这里开始连续 30 秒
#   前 300 刻盾在身上（15 秒），后 300 刻纯冷却
#   cd 到 ..300 时由 tick 触发 skill/tank_expire 清盾
#   cd 到 0 时由 tick 触发兜底补发新令牌
#
# === 盾牌 NBT 说明 ===
#   1.20.1 盾牌最大耐久固定 336，没有"设置最大耐久"的 NBT 字段。
#   要实现设计文档的"耐久 80"，用 Damage 反推：
#       Damage = 336 - 80 = 256
#   KitShield:1b 是本职业盾的私有标记。
#   skill/tank_expire 依靠它定位并清理。
#   不要给这个盾加 Unbreakable——会破坏"耐久 80 能用完"的设计。

give @s minecraft:shield{KitShield:1b,Damage:256} 1

tag @s add kitpvp.shield_held

scoreboard players set @s kitpvp.cd 600

title @s actionbar {"text":"举盾：获得 15 秒护盾","color":"gold"}
playsound minecraft:item.armor.equip_iron master @s ~ ~ ~ 0.8 1.0
```

---

### 7. 盾到期清盾

文件路径：`src\data\kitpvp\functions\skill\tank_expire.mcfunction`

```mcfunction
# ===== 坦克：护盾 15 秒到期 =====
# 触发：tick.mcfunction 检测到 cd <= 300 且 tag=kitpvp.shield_held
# @s = 持盾者
#
# 责任：
#   1. 清掉背包里带 KitShield 标记的盾
#   2. 摘掉持盾标记，防止 tick 重复触发
#   3. 提示本机玩家
#
# ⚠ 已知取舍：若玩家把盾丢地上被别人捡走，那把盾不会被本函数清掉
#   （clear @s 只作用于持有者）。流出的盾仍带 80 点剩余耐久，用完即碎，
#   不构成刷物品漏洞。

clear @s minecraft:shield{KitShield:1b}
tag @s remove kitpvp.shield_held

title @s actionbar {"text":"护盾已消失","color":"gray"}
```

---

## 二、改动文件（给完整正文）

### 8. 加载钩子

文件路径：`src\data\kitpvp\functions\load.mcfunction`

```mcfunction
# 数据包加载时执行一次
# 一、游戏规则
gamerule keepInventory true
gamerule doMobSpawning false
gamerule mobGriefing false
gamerule doFireTick false
gamerule doInsomnia false
gamerule naturalRegeneration true
gamerule fallDamage true
gamerule announceAdvancements false
gamerule doImmediateRespawn true
gamerule sendCommandFeedback false
gamerule logAdminCommands false
gamerule commandBlockOutput false

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
scoreboard objectives add kitpvp.gapple_used minecraft.used:minecraft.golden_apple
scoreboard objectives add kitpvp.gapple_last dummy "金苹果快照"
scoreboard objectives add kitpvp.tank_used minecraft.used:minecraft.iron_golem_spawn_egg
scoreboard objectives add kitpvp.tank_last dummy "坦克技能快照"

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

# 七、清空 storage
data remove storage kitpvp:main temp
data remove storage kitpvp:main player

say Kitpvp loaded
```

---

### 9. 每刻钩子

文件路径：`src\data\kitpvp\functions\tick.mcfunction`

```mcfunction
# 每游戏刻执行
# 玩家接入检测：未登记的玩家 → 走 join 流程
execute as @a[tag=!kitpvp.joined] run function kitpvp:player/join

# 冷却递减
execute as @a[scores={kitpvp.cd=1..}] run scoreboard players remove @s kitpvp.cd 1
execute as @a[scores={kitpvp.cd2=1..}] run scoreboard players remove @s kitpvp.cd2 1

# ===== 坦克：举盾令牌使用检测 =====
# 统计 objective：右键铁傀儡刷怪蛋的瞬间 used 自动 +1
# 本刻 used 比 last 大 → 刚用掉令牌，转交 skill/tank_cast
# 必须在"冷却递减"之后再跑，避免 cd 被本 tick 的递减覆盖
execute as @a[scores={kitpvp.kit=3,kitpvp.alive=1}] if score @s kitpvp.tank_used > @s kitpvp.tank_last run function kitpvp:skill/tank_cast

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
execute as @a[scores={kitpvp.kit=3}] at @s run kill @e[type=iron_golem,distance=..16]

# ===== 坦克：举盾令牌兜底补发 =====
# 冷却结束、背包里又没有令牌时，补发一个，让坦克能继续施法
# 判据：Inventory 里存在任一带 KitTankEgg:1b 标记的物品
# 玩家"丢令牌"会形成物品堆积，但每个令牌只相当于一次技能使用，不放大技能次数
execute as @a[scores={kitpvp.kit=3,kitpvp.alive=1,kitpvp.cd=0},tag=!kitpvp.spectator] unless data entity @s Inventory[{tag:{KitTankEgg:1b}}] run function kitpvp:skill/tank_give_egg

# ===== 战士金苹果消耗检测 =====
# 统计 objective：吃掉金苹果的瞬间 used 自动 +1
# 本刻 used 比 last 大 → 刚吃掉，转交 warrior_consume
# 必须在"冷却递减"之后再跑，避免 cd 被本 tick 的递减覆盖
execute as @a[scores={kitpvp.kit=1,kitpvp.alive=1}] if score @s kitpvp.gapple_used > @s kitpvp.gapple_last run function kitpvp:skill/warrior_consume

# ===== 弓箭手：清除落地的箭 =====
# 弓箭手射出的箭一落地（inGround:1b）就清除，
# 防止"射出去 → 换弹 → 再捡回来"把箭数刷过 12 支上限。
# 副作用：会一并清掉其它来源（如骷髅）落地的箭。
kill @e[type=minecraft:arrow,nbt={inGround:1b}]

# ===== 职业技能结算（统一入口）=====
# 只筛"有职业、活着、主技能冷却归零"的玩家，转交 dispatch；
# 具体哪个职业发什么，由 skill/dispatch 按 kitpvp.kit 分派。
# 新增自动技能请改 skill/dispatch，不要在这里加行。
# 主动技能不经过本行——它们由各自的触发器接（参见坦克）。
execute as @a[scores={kitpvp.kit=1..,kitpvp.alive=1}] if score @s kitpvp.cd matches ..0 run function kitpvp:skill/dispatch

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
execute as @a[tag=!kitpvp.spectator] if score @s kitpvp.death_detect > @s kitpvp.death_seen run function kitpvp:player/death_dispatch

# 重生后处理（由 on_death 打 tag，本 tick 消费）
execute as @a[tag=kitpvp.respawn_pending,tag=!kitpvp.spectator] run function kitpvp:player/after_death

# ===== 胜负兜底轮询（每 20 刻一次）=====
# 覆盖"玩家中途退出服务器导致幸存者减少，但没人触发 eliminate"的情况
scoreboard players add #tick kitpvp.game 1
execute if score #tick kitpvp.game matches 20.. run scoreboard players set #tick kitpvp.game 0
execute if score #tick kitpvp.game matches 0 if score #state kitpvp.game matches 1 run function kitpvp:game/check_winner
```

---

### 10. 技能分发层

文件路径：`src\data\kitpvp\functions\skill\dispatch.mcfunction`

```mcfunction
# ===== 技能分发层 =====
# 调用方：tick.mcfunction
# 入口条件由 tick 过滤：kitpvp.kit >= 1 且 kitpvp.alive = 1 且 kitpvp.cd <= 0
# 也就是说，进入本函数时"应该结算技能"这个前提已经成立。
#
# 本函数只做一件事：按 kitpvp.kit 的值，转交到对应职业的技能函数。
# 新增职业时，只在下方追加一行，不要动 tick.mcfunction。
#
# ⚠ 强制约定（每个职业技能函数必须遵守）：
#   1) 自动技能函数末尾必须自己设冷却：
#        scoreboard players set @s kitpvp.cd <刻数>
#      漏写会导致 cd 一直停在 0，tick 每刻重复调用，技能无限触发。
#   2) 条件未满足时（例如战士背包里已有金苹果、上限已满），
#      不要设长冷却，set cd 0（或干脆不动）即可，让下一刻重试。
#      战士用的就是这个模式：吃到金苹果后下一刻立刻补发。
#   3) 主动技能不进本函数。主动技能靠"检测玩家操作"接：
#      坦克的举盾 → 统计 objective kitpvp.tank_used（铁傀儡刷怪蛋被使用）
#                 → ticp.mcfunction 检测 used > last
#                 → skill/tank_cast → skill/tank_fire
#      新增主动技能时，按同样模式：一个统计 objective + 一个 xxx_cast 入口。
#
# kit 编号对照（与 util/give_kit.mcfunction 保持一致）：
#   1 战士   2 弓箭手   3 坦克   4 刺客
#   后续每 1 个职业顺延 1 号

# kit = 1 战士 · 补给（自动）
execute if score @s kitpvp.kit matches 1 run function kitpvp:skill/warrior

# kit = 2 弓箭手 · 换弹（触发器驱动，见 advancement archer_pickup）
# execute if score @s kitpvp.kit matches 2 run function kitpvp:skill/archer

# kit = 3 坦克 · 举盾（主动技能，由统计 objective 驱动，不进 dispatch）
# 链路：minecraft.used:minecraft.iron_golem_spawn_egg > kitpvp.tank_last
#       → skill/tank_cast → skill/tank_fire

# kit = 4 刺客 · 隐匿（未实装）
# execute if score @s kitpvp.kit matches 4 run function kitpvp:skill/assassin
```

---

### 11. 按 kit 重发装备

文件路径：`src\data\kitpvp\functions\util\give_kit.mcfunction`

```mcfunction
# ===== 按 kit 分数重发职业装备 =====
# 每个职业函数内部自行负责：装备、属性、永久效果、命数、tag

execute if score @s kitpvp.kit matches 1 run function kitpvp:kit/warrior
execute if score @s kitpvp.kit matches 2 run function kitpvp:kit/archer
execute if score @s kitpvp.kit matches 3 run function kitpvp:kit/tank
# execute if score @s kitpvp.kit matches 4 run function kitpvp:kit/assassin
# …… 新增职业时按同格式追加
# ……
```

---

### 12. 玩家加入

文件路径：`src\data\kitpvp\functions\player\join.mcfunction`

```mcfunction
# 玩家加入服务器
# ===== 玩家生命周期起点 =====
# 由根 tick 通过 [tag=!kitpvp.joined] 检测触发，每会话各跑一次

# 登记已加入，防止 tick 每刻重复触发
tag @s add kitpvp.joined

# 基础状态初始化
scoreboard players set @s kitpvp.kit 0
scoreboard players set @s kitpvp.cd 0
scoreboard players set @s kitpvp.cd2 0
scoreboard players set @s kitpvp.alive 1
scoreboard players set @s kitpvp.lives 3
scoreboard players set @s kitpvp.kills 0
scoreboard players set @s kitpvp.deaths 0
scoreboard players set @s kitpvp.inv 0
scoreboard players operation @s kitpvp.death_seen = @s kitpvp.death_detect
scoreboard players set @s kitpvp.item 0
scoreboard players operation @s kitpvp.gapple_last = @s kitpvp.gapple_used
# 坦克统计快照：把 last 推到当前 used，防止老玩家一进服被误判"刚用掉令牌"
scoreboard players operation @s kitpvp.tank_last = @s kitpvp.tank_used

# 进入主大厅（负责 add kitpvp.in_lobby）
function kitpvp:lobby/enter
```

---

### 13. 重生后处理

文件路径：`src\data\kitpvp\functions\player\after_death.mcfunction`

```mcfunction
# ===== 重生后处理 =====
# 由根 tick.mcfunction 在玩家重生于 spawnpoint 之后调用
# 此时原版已经把玩家放到 spawnpoint 上（doImmediateRespawn=true）

# 消费标记
tag @s remove kitpvp.respawn_pending

# 死亡会清空全部药水效果，重生后重新挂上职业被动
# 其他职业有被动时，在此按同格式追加
execute if score @s kitpvp.kit matches 3 run function kitpvp:kit/tank_passive

# 重生后补发举盾令牌（如果死亡时背包里已经没有了）
execute if score @s kitpvp.kit matches 3 run function kitpvp:skill/tank_give_egg

# 5 秒无敌
function kitpvp:player/invincible

# 提示
playsound minecraft:block.note_block.pling master @s ~ ~ ~ 1 1.2
```

---

### 14. 淘汰

文件路径：`src\data\kitpvp\functions\player\eliminate.mcfunction`

```mcfunction
# ===== 命数归 0：淘汰进入旁观 =====

# 不再重生
tag @s remove kitpvp.respawn_pending
tag @s remove kitpvp.invincible

# 清理职业性 tag（旁观的玩家不再持有任何专职技能标记）
tag @s remove kitpvp.shield_held
tag @s remove kitpvp.skill_ready
tag @s remove kitpvp.skill_consume

scoreboard players set @s kitpvp.lives 0
scoreboard players set @s kitpvp.alive 0
scoreboard players set @s kitpvp.inv 0
tag @s add kitpvp.spectator

gamemode spectator @s
clear @s
effect clear @s
tag @s remove kitpvp.selected

title @s times 5 40 10
title @s title {"text":"你死完了！","color":"red","bold":true}
playsound minecraft:entity.villager.death master @s ~ ~ ~ 1 0.6

tellraw @a [{"text":"[淘汰] ","color":"dark_red","bold":true},{"selector":"@s","color":"white"},{"text":" 已死完","color":"red"}]

# 胜负判定（完整结算流程见 2.11）
function kitpvp:game/check_winner
```

---

### 15. 清场

文件路径：`src\data\kitpvp\functions\util\clear_player.mcfunction`

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
scoreboard players operation @s kitpvp.gapple_last = @s kitpvp.gapple_used
# 坦克统计快照：清场时把 last 推到 used，避免清场后下一刻误判
scoreboard players operation @s kitpvp.tank_last = @s kitpvp.tank_used

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

### 16. 职业分类列表（追加坦克条目）

文件路径：`src\data\kitpvp\functions\kit\list\classic.mcfunction`

```mcfunction
# ===== 职业列表：经典（表） =====
# 由 kit/list 的 [经典（表）] 按钮触发
# 新增职业时，在 [返回] 之前按同格式追加一行

tellraw @s [{"text":"═══ 经典（表） ═══","color":"green","bold":true}]
tellraw @s [{"text":"[战士] ","color":"green","bold":true,"clickEvent":{"action":"run_command","value":"/function kitpvp:kit/info/warrior"},"hoverEvent":{"action":"show_text","contents":[{"text":"铁甲冲锋的正面战士","color":"gray"}]}},{"text":"铁甲冲锋的正面战士","color":"dark_gray"}]
tellraw @s [{"text":"[弓箭手] ","color":"green","bold":true,"clickEvent":{"action":"run_command","value":"/function kitpvp:kit/info/archer"},"hoverEvent":{"action":"show_text","contents":[{"text":"远程消耗的射手","color":"gray"}]}},{"text":"远程消耗的射手","color":"dark_gray"}]
tellraw @s [{"text":"[坦克] ","color":"green","bold":true,"clickEvent":{"action":"run_command","value":"/function kitpvp:kit/info/tank"},"hoverEvent":{"action":"show_text","contents":[{"text":"高护甲低速的肉盾","color":"gray"}]}},{"text":"高护甲低速的肉盾","color":"dark_gray"}]
tellraw @s [{"text":"[返回]","color":"yellow","clickEvent":{"action":"run_command","value":"/function kitpvp:kit/list"},"hoverEvent":{"action":"show_text","contents":[{"text":"回到分类列表","color":"gray"}]}}]
```

---

## 三、时间线演示

| 时刻 | cd | 事件 |
|---|---|---|
| t=0（右键瞬间）| 0 | 玩家右键令牌 → 铁傀儡生成、统计 `tank_used` +1 |
| t=1 tick 头 | 0 | tick 检测 `used>last` → `tank_cast` → `tank_fire`：**give 盾、tag add、cd=600** |
| t=1 tick 内 | 600→599 | 盾到期检测 `cd=..300` 不触发；`kill @e[type=iron_golem,distance=..16]` 清掉铁傀儡 |
| t=1~300 | 600→300 | 盾在身上（有效 15 秒） |
| t=300 | 301→300 | tick 判定 `cd<=300 && tag=shield_held` → `tank_expire`：清盾、摘 tag |
| t=300~600 | 300→0 | 纯冷却 |
| t=600 | 1→0 | 蛋兜底检测 `cd=0 && 背包没蛋` → `tank_give_egg` 补发令牌 |
| t=600+ | 0 | 等待玩家再次右键 |

**冷却从给盾一瞬间开始** —— 对应 `tank_fire` 里 `set cd 600` 是最后一步。

---

## 四、自检（对应 04-hazards 第四节清单）

- [x] 冷却判据是"**真正用掉了令牌**"（`minecraft.used` 统计），不是"背包里没有令牌"
- [x] 令牌被使用 → 走 `used > last` 分支；令牌被丢弃 → 统计不动、不触发冷却
- [x] 有 `kitpvp.shield_held` 明确表示"盾待消耗"，给盾 `add`、到期 `remove`
- [x] `tank_last` 快照在 **`player/join`** 与 **`util/clear_player`** 都做了初始化（照抄 `gapple_last` 的模式）
- [x] 掉线重连不会被误判"刚用过"（`join` 里把 last 推到当前 used）
- [x] 背包满时 `give` 会掉地上，令牌会按"背包里没有 → 补发"逻辑尽力恢复；不会与 tag 冲突
- [x] 冷却只由 `kitpvp.cd` 一个变量驱动，同一 tick 内不会被写两次
- [x] 生成物（铁傀儡）用 `distance=..16` 立即 `kill`，不留残局
- [x] 被淘汰的旁观者不会参与（`tag=!kitpvp.spectator`）

---

## 五、不确定项（**请用 `/help` 或实测确认，不要照抄**）

- **`minecraft.used:minecraft.iron_golem_spawn_egg` 是否真的会被 `minecraft.used` 统计到**。1.20.1 的 `minecraft.used` 一般覆盖所有物品的使用，但刷怪蛋属于比较特殊的"即时使用"，**我没法 100% 保证它一定计入**。请按下面步骤实测：
  1. 在 `load` 里加 `scoreboard objectives add kitpvp.tank_used minecraft.used:minecraft.iron_golem_spawn_egg` 后 `/reload`；
  2. 拿一个铁傀儡刷怪蛋右键，然后 `/scoreboard players get @s kitpvp.tank_used` 看有没有 +1；
  3. 有 → 本方案 OK；没有 → 见下方备选。

- **备选方案（如果 `minecraft.used` 对刷怪蛋不计数）**：改成"背包里没有令牌 = 刚用掉"。做法是把 `skill/tank_cast.mcfunction` 的调用点从 tick 的"统计检测"换成：
  ```mcfunction
  execute as @a[scores={kitpvp.kit=3,kitpvp.alive=1,kitpvp.cd=0},tag=!kitpvp.spectator] unless data entity @s Inventory[{tag:{KitTankEgg:1b}}] run function kitpvp:skill/tank_cast
  ```
  代价：玩家"丢令牌"也会被判为"用掉了"（会误放一次盾 + 进冷却）。**在换方案前先测一下**。

- **盾牌最大耐久是否为 336**：1.20.1 一贯是 336。若实测发现 `Damage:256` 后显示的耐久不是 80，用 `data get entity @s Inventory[...]` 看实际 Damage 值再调整。

- **1.20.1 没有 `/return`**，所以 `tank_cast` 用两条互斥的 `execute if score ... run` 分支，不是提前返回。

- **`距离 distance=..16` 会误杀地图装饰铁傀儡**：如果某张地图里有装饰性铁傀儡落在坦克 16 格内，会被清掉。真出事的话把 `..16` 改成 `..6`（刷怪蛋射程约 4.5 格，`..6` 已经够覆盖）。

---

## 六、给 hazard 文档的建议补充

在你的 `04-hazards-reminder.md` 加一节：

> **主动技能的通用模式（1.20.1）**：主动技能不能挂 `tick → dispatch`，必须靠"检测玩家操作"来触发。当前项目里用**统计 objective**（如 `minecraft.used:minecraft.iron_golem_spawn_egg`）检测"用掉了专属物品"，tick 里比对 `used > last` 后转交 `skill/xxx_cast`。触发物默认选**颜色贴主题的刷怪蛋**（坦克用铁傀儡），生成物由 tick 立刻 `kill`。函数入口首行必须是快照推进（`operation last = used`），否则每刻重复触发。令牌的快照变量要在 `player/join` 与 `util/clear_player` 都初始化。