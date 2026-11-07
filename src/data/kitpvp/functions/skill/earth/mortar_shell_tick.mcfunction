# @s = 迫击炮的鱼弹（as @s at @s）：飞向开炮那一刻锁定的落点（kitpvp.mo_aim），走一条先升后落的弧线
# 落点开炮时固定，之后不再追人 ⇒ 玩家跑开就打空，也不会在头顶悬停
# 水平：每刻朝落点转向，再沿朝向前进（速度按开炮距离分档，存在 mo_hs）
# 竖直：mo_vy 每刻 -1，位移查表 ⇒ 位移 ∝ 时间的平方、开口向下
scoreboard players add @s kitpvp.mo_life 1
execute if entity @e[tag=kitpvp.mo_aim,limit=1] at @s run tp @s ~ ~ ~ facing entity @e[tag=kitpvp.mo_aim,limit=1] feet
execute if entity @e[tag=kitpvp.mo_aim,limit=1] at @s if score @s kitpvp.mo_hs matches 42 run tp @s ^ ^ ^0.42
execute if entity @e[tag=kitpvp.mo_aim,limit=1] at @s if score @s kitpvp.mo_hs matches 55 run tp @s ^ ^ ^0.55
execute if entity @e[tag=kitpvp.mo_aim,limit=1] at @s if score @s kitpvp.mo_hs matches 68 run tp @s ^ ^ ^0.68
execute if entity @e[tag=kitpvp.mo_aim,limit=1] at @s if score @s kitpvp.mo_hs matches 82 run tp @s ^ ^ ^0.82
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
