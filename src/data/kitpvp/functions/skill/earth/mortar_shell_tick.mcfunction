# @s = 迫击炮的鱼弹（as @s at @s）：飞向开炮那一刻锁定的落点（kitpvp.mo_aim）
# 水平：每刻用 execute facing 把朝向指向落点，再沿朝向迈一步（速度分档在 mo_hs）
# 竖直：mo_vy 每刻 -1，位移查表 ⇒ 位移 ∝ 时间的平方、开口向下
scoreboard players add @s kitpvp.mo_life 1
execute if entity @e[tag=kitpvp.mo_aim,limit=1] at @s facing entity @e[tag=kitpvp.mo_aim,limit=1] feet if score @s kitpvp.mo_hs matches 42 run tp @s ^ ^ ^0.42
execute if entity @e[tag=kitpvp.mo_aim,limit=1] at @s facing entity @e[tag=kitpvp.mo_aim,limit=1] feet if score @s kitpvp.mo_hs matches 55 run tp @s ^ ^ ^0.55
execute if entity @e[tag=kitpvp.mo_aim,limit=1] at @s facing entity @e[tag=kitpvp.mo_aim,limit=1] feet if score @s kitpvp.mo_hs matches 68 run tp @s ^ ^ ^0.68
execute if entity @e[tag=kitpvp.mo_aim,limit=1] at @s facing entity @e[tag=kitpvp.mo_aim,limit=1] feet if score @s kitpvp.mo_hs matches 82 run tp @s ^ ^ ^0.82
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
# 临时探针（查完就删）：第 3 刻和第 12 刻各报一次"离落点多远"
execute if score @s kitpvp.mo_life matches 3 at @e[tag=kitpvp.mo_aim,limit=1] if entity @s[distance=..3] run tellraw @a {"text":"[鱼·3刻] 离落点 0-3 格","color":"red"}
execute if score @s kitpvp.mo_life matches 3 at @e[tag=kitpvp.mo_aim,limit=1] if entity @s[distance=3..8] run tellraw @a {"text":"[鱼·3刻] 离落点 3-8 格","color":"yellow"}
execute if score @s kitpvp.mo_life matches 3 at @e[tag=kitpvp.mo_aim,limit=1] if entity @s[distance=8..14] run tellraw @a {"text":"[鱼·3刻] 离落点 8-14 格","color":"aqua"}
execute if score @s kitpvp.mo_life matches 3 at @e[tag=kitpvp.mo_aim,limit=1] if entity @s[distance=14..] run tellraw @a {"text":"[鱼·3刻] 离落点 14+ 格","color":"green"}
execute if score @s kitpvp.mo_life matches 12 at @e[tag=kitpvp.mo_aim,limit=1] if entity @s[distance=..3] run tellraw @a {"text":"[鱼·12刻] 离落点 0-3 格","color":"red"}
execute if score @s kitpvp.mo_life matches 12 at @e[tag=kitpvp.mo_aim,limit=1] if entity @s[distance=3..8] run tellraw @a {"text":"[鱼·12刻] 离落点 3-8 格","color":"yellow"}
execute if score @s kitpvp.mo_life matches 12 at @e[tag=kitpvp.mo_aim,limit=1] if entity @s[distance=8..14] run tellraw @a {"text":"[鱼·12刻] 离落点 8-14 格","color":"aqua"}
execute if score @s kitpvp.mo_life matches 12 at @e[tag=kitpvp.mo_aim,limit=1] if entity @s[distance=14..] run tellraw @a {"text":"[鱼·12刻] 离落点 14+ 格","color":"green"}
# 引爆：飞到落点 2 格内，或满 30 刻兜底
execute at @e[tag=kitpvp.mo_aim,limit=1] if entity @s[distance=..2] run function kitpvp:skill/earth/mortar_burst
execute if score @s kitpvp.mo_life matches 30.. run function kitpvp:skill/earth/mortar_burst
