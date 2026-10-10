# ===== 幽灵魂石：右键 → 使用者隐身 20 秒，期间攻击玩家召阴兵 =====
# 调用方：tick.mcfunction 检测到 soul_ghost_used > soul_ghost_last
# @s = 使用者
#
# 本函数做四件事：
#   1. 推进 last 快照（铁律，漏写会每刻重复触发）
#   2. 清掉右键生成的凋灵骷髅
#   3. 给使用者隐身 20 秒 + 激活标记 + 倒计时归零
#   4. 队槽与队成员在第一次召唤阴兵时才处理（惰性分配）

scoreboard players operation @s kitpvp.soul_ghost_last = @s kitpvp.soul_ghost_used

execute at @s run kill @e[type=vex,name="幽灵魂石"]

effect give @s minecraft:invisibility 20 0 true

tag @s add kitpvp.soul_ghost_active
scoreboard players set @s kitpvp.soul_ghost_timer 400
scoreboard players set @s kitpvp.ghost_minion_cd 0

title @s actionbar {"text":"魂石·幽影：隐身（20 秒），攻击玩家可召阴兵","color":"dark_aqua"}
playsound minecraft:entity.vex.ambient master @s ~ ~ ~ 0.8 1.0
