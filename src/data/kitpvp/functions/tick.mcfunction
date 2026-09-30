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
execute as @a[scores={kitpvp.kit=3}] at @s run kill @e[type=iron_golem,distance=..16,name="举盾令牌"]

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

# ===== 刺客：隐匿令牌使用检测 =====
# 统计 objective：右键末影人刷怪蛋的瞬间 used 自动 +1
# 本刻 used 比 last 大 → 刚用掉令牌，转交 skill/assassin_cast
# 必须在"冷却递减"之后再跑，避免 cd 被本 tick 的递减覆盖
execute as @a[scores={kitpvp.kit=4,kitpvp.alive=1}] if score @s kitpvp.assassin_used > @s kitpvp.assassin_last run function kitpvp:skill/assassin_cast

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
execute as @a[tag=!kitpvp.spectator,tag=!kitpvp.respawn_pending] if score @s kitpvp.death_detect > @s kitpvp.death_seen run function kitpvp:player/death_dispatch

# 重生后处理（由 on_death 打 tag，本 tick 消费）
execute as @a[tag=kitpvp.respawn_pending,tag=!kitpvp.spectator] run function kitpvp:player/after_death

# ===== 胜负兜底轮询（每 20 刻一次）=====
# 覆盖"玩家中途退出服务器导致幸存者减少，但没人触发 eliminate"的情况
scoreboard players add #tick kitpvp.game 1
execute if score #tick kitpvp.game matches 20.. run scoreboard players set #tick kitpvp.game 0
execute if score #tick kitpvp.game matches 0 if score #state kitpvp.game matches 1 run function kitpvp:game/check_winner