# @s = 迫击炮的鱼弹（as @s at @s）：飞向开炮那一刻锁定的落点（kitpvp.mo_aim），自身走一条开口向下的抛物线
# 水平：方向朝落点（落点不动 ⇒ 每刻方向相同），速度由开炮时按距离定好的 mo_hs 决定 ⇒ 水平位移 ∝ 时间
# 竖直：mo_vy 每刻 -1，位移查表 ⇒ 位移 ∝ 时间的平方、开口向下
# 两者合起来就是标准抛物线；不会在头顶悬停，因为它压根不看你，只看那个落点
scoreboard players add @s kitpvp.mo_life 1
execute if entity @e[tag=kitpvp.mo_aim,limit=1] at @s run tp @s ~ ~ ~ facing entity @e[tag=kitpvp.mo_aim,limit=1] feet
execute if score @s kitpvp.mo_hs matches 42 rotated ~ 0 run tp @s ^ ^ ^0.42
execute if score @s kitpvp.mo_hs matches 55 rotated ~ 0 run tp @s ^ ^ ^0.55
execute if score @s kitpvp.mo_hs matches 68 rotated ~ 0 run tp @s ^ ^ ^0.68
execute if score @s kitpvp.mo_hs matches 82 rotated ~ 0 run tp @s ^ ^ ^0.82
execute if score @s kitpvp.mo_vy matches 11.. run tp @s ~ ~0.95 ~
execute if score @s kitpvp.mo_vy matches 9..10 run tp @s ~ ~0.8 ~
execute if score @s kitpvp.mo_vy matches 7..8 run tp @s ~ ~0.65 ~
execute if score @s kitpvp.mo_vy matches 5..6 run tp @s ~ ~0.5 ~
execute if score @s kitpvp.mo_vy matches 3..4 run tp @s ~ ~0.35 ~
execute if score @s kitpvp.mo_vy matches 1..2 run tp @s ~ ~0.2 ~
execute if score @s kitpvp.mo_vy matches -1..0 run tp @s ~ ~0 ~
execute if score @s kitpvp.mo_vy matches -3..-2 run tp @s ~ ~-0.35 ~
execute if score @s kitpvp.mo_vy matches -5..-4 run tp @s ~ ~-0.5 ~
execute if score @s kitpvp.mo_vy matches -7..-6 run tp @s ~ ~-0.65 ~
execute if score @s kitpvp.mo_vy matches -9..-8 run tp @s ~ ~-0.8 ~
execute if score @s kitpvp.mo_vy matches ..-10 run tp @s ~ ~-0.95 ~
scoreboard players remove @s kitpvp.mo_vy 1
# 引爆：飞到落点 2 格内，或满 30 刻兜底（距离算错时不会永远飞下去）
execute at @e[tag=kitpvp.mo_aim,limit=1] if entity @s[distance=..2] run function kitpvp:skill/earth/mortar_burst
execute if score @s kitpvp.mo_life matches 30.. run function kitpvp:skill/earth/mortar_burst
