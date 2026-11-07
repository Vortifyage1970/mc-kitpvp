# @s = 迫击炮的鱼弹（at @s）：走一条真正的抛物线
# 关键：水平位移只沿"水平朝向"（先把 pitch 归零再前移），上下完全由 mo_vy 决定 ——
# 速度每刻 -1，位移就是时间的二次函数，这才叫抛物线。以前一边朝脚底飞一边加竖直，
# 上抛被"朝下瞄准"抵掉了，看起来像巡航导弹而不是迫击炮。
scoreboard players add @s kitpvp.mo_life 1
execute if entity @p[tag=kitpvp.mo_tgt,limit=1] at @s run tp @s ~ ~ ~ facing entity @p[tag=kitpvp.mo_tgt,limit=1] feet
execute if entity @p[tag=kitpvp.mo_tgt,limit=1] at @s rotated ~ 0 run tp @s ^ ^ ^0.85
# 竖直：mo_vy 从 12 递减，分档给位移（1.20.1 没有数学函数，除以 0.05 做不到，就查表）
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
# 引爆：贴到目标 2 格内，或者飞满 30 刻（弧顶 7 格高、约 24 刻落回炮口高度）
execute if entity @p[tag=kitpvp.mo_tgt,distance=..2] run function kitpvp:skill/earth/mortar_burst
execute if score @s kitpvp.mo_life matches 30.. run function kitpvp:skill/earth/mortar_burst
