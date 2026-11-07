# @s = 迫击炮的鱼弹（as @s at @s）
# 水平：每刻朝落点前进 hs/100 格；竖直：按 mo_vy 表升降，位移对时间近似二次函数
# 注意：函数里每个 tp 都要先 `at @s` 重新取当前坐标。不写就会用"函数开始那一刻"的旧坐标，
# 把上一行刚挪过去的位置又拽回炮口 —— 表现就是鱼只升不横移、贴着头顶飘。
scoreboard players add @s kitpvp.mo_life 1
# 水平档：先把朝向对准落点（只取偏航），再用 `rotated ~ 0` 把俯仰压平 -> `^` 就是纯水平位移。
# 不压平的话 `^` 会顺着"炮口到落点"的视线往下斜，竖直分量吃掉一截水平行程，落点就系统性偏近。
execute if entity @e[tag=kitpvp.mo_aim,limit=1] at @s run tp @s ~ ~ ~ facing entity @e[tag=kitpvp.mo_aim,limit=1] feet
execute if entity @e[tag=kitpvp.mo_aim,limit=1] at @s rotated ~ 0 if score @s kitpvp.mo_hs matches 1..21 run tp @s ^ ^ ^0.15
execute if entity @e[tag=kitpvp.mo_aim,limit=1] at @s rotated ~ 0 if score @s kitpvp.mo_hs matches 22..31 run tp @s ^ ^ ^0.27
execute if entity @e[tag=kitpvp.mo_aim,limit=1] at @s rotated ~ 0 if score @s kitpvp.mo_hs matches 32..41 run tp @s ^ ^ ^0.36
execute if entity @e[tag=kitpvp.mo_aim,limit=1] at @s rotated ~ 0 if score @s kitpvp.mo_hs matches 42..47 run tp @s ^ ^ ^0.45
execute if entity @e[tag=kitpvp.mo_aim,limit=1] at @s rotated ~ 0 if score @s kitpvp.mo_hs matches 48..51 run tp @s ^ ^ ^0.5
execute if entity @e[tag=kitpvp.mo_aim,limit=1] at @s rotated ~ 0 if score @s kitpvp.mo_hs matches 52..54 run tp @s ^ ^ ^0.53
execute if entity @e[tag=kitpvp.mo_aim,limit=1] at @s rotated ~ 0 if score @s kitpvp.mo_hs matches 55.. run tp @s ^ ^ ^0.55
execute if score @s kitpvp.mo_vy matches 11.. at @s run tp @s ~ ~0.95 ~
execute if score @s kitpvp.mo_vy matches 9..10 at @s run tp @s ~ ~0.8 ~
execute if score @s kitpvp.mo_vy matches 7..8 at @s run tp @s ~ ~0.65 ~
execute if score @s kitpvp.mo_vy matches 5..6 at @s run tp @s ~ ~0.5 ~
execute if score @s kitpvp.mo_vy matches 3..4 at @s run tp @s ~ ~0.35 ~
execute if score @s kitpvp.mo_vy matches 1..2 at @s run tp @s ~ ~0.2 ~
execute if score @s kitpvp.mo_vy matches -1..0 at @s run tp @s ~ ~0 ~
execute if score @s kitpvp.mo_vy matches -3..-2 at @s run tp @s ~ ~-0.35 ~
execute if score @s kitpvp.mo_vy matches -5..-4 at @s run tp @s ~ ~-0.5 ~
execute if score @s kitpvp.mo_vy matches -7..-6 at @s run tp @s ~ ~-0.65 ~
execute if score @s kitpvp.mo_vy matches -9..-8 at @s run tp @s ~ ~-0.8 ~
execute if score @s kitpvp.mo_vy matches ..-10 at @s run tp @s ~ ~-0.95 ~
scoreboard players remove @s kitpvp.mo_vy 1
execute at @e[tag=kitpvp.mo_aim,limit=1] if entity @s[distance=..2] run function kitpvp:skill/earth/mortar_burst
execute if score @s kitpvp.mo_life matches 46.. run function kitpvp:skill/earth/mortar_burst
