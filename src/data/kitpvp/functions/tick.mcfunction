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

# ===== 纵火狂 =====
# 投掷燃烧瓶检测（统计 objective）
execute as @a[scores={kitpvp.kit=5,kitpvp.alive=1},tag=!kitpvp.spectator] if score @s kitpvp.arsonist_used > @s kitpvp.arsonist_last run function kitpvp:skill/arsonist_cast

# 燃烧瓶即将落地 → 铺火
# @e 选择器依赖药水实体的 Item.tag，只有带 KitFireBomb 标记的喷溅药水会被捕捉
execute as @e[type=minecraft:potion,nbt={Item:{tag:{KitFireBomb:1b}}},tag=!kitpvp.arsonist_burst] at @s unless block ~ ~-0.5 ~ air unless block ~ ~-0.5 ~ cave_air unless block ~ ~-0.5 ~ void_air run function kitpvp:skill/arsonist_burst

# 掉进虚空的燃烧瓶直接清掉，不放火
# 副作用：只会命中药水实体，不涉及其它实体
kill @e[type=minecraft:potion,nbt={Item:{tag:{KitFireBomb:1b}}},y=-100,dy=100]

# 火焰 5 秒保护
function kitpvp:skill/arsonist_flame_tick

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
