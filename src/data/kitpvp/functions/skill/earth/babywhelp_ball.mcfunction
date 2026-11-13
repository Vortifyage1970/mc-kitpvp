# @s = 飞龙宝宝吐出的火球（small_fireball）
# ⚠ 它自己的 Motion 是 0、带 NoGravity：这个火球完全靠下面的 tp 飞，不让原版物理碰它。
#   原因：原版小火球砸到方块会就地放火，而且无视 mobGriefing（MC-70251）——
#   让它自己飞，射偏一发竞技场就着一块。零速度时原版的命中检测长度为 0，永远不会触发。
scoreboard players add @s kitpvp.bw_life 1
# 尾迹
execute at @s run particle minecraft:flame ~ ~ ~ 0.05 0.05 0.05 0.01 2
execute at @s run particle minecraft:lava ~ ~ ~ 0.04 0.04 0.04 0 1
# 沿吐出那一刻的朝向直线前进 0.8 格/刻（`at @s` 会把这只火球自己的 Rotation 带进 ^ 的计算里）
execute at @s run tp @s ^ ^ ^0.8
# 撞到方块：冒烟熄灭，不烧方块、不伤自己人
execute at @s unless block ~ ~ ~ minecraft:air unless block ~ ~ ~ minecraft:cave_air unless block ~ ~ ~ minecraft:void_air run function kitpvp:skill/earth/babywhelp_fizzle
# 命中玩家（1.5 格内）→ 结算伤害
execute at @s if entity @a[distance=..1.5,gamemode=!spectator,tag=!kitpvp.spectator] run function kitpvp:skill/earth/babywhelp_hit
# 寿命上限 40 刻（约 16 格），没打到任何东西也会消失
execute if score @s kitpvp.bw_life matches 40.. run function kitpvp:skill/earth/babywhelp_fizzle
