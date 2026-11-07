# @s = 迫击炮的鱼弹（at @s）：每刻朝目标挪一点，垂直速度 mo_vy 每刻 -1 —— 先升后落就是一条抛物线
scoreboard players add @s kitpvp.mo_life 1
# 水平：朝目标脚下一格一格压过去（远距离时这条 3D 线几乎是水平的，弧线主要靠下面的 mo_vy）
execute if entity @p[tag=kitpvp.mo_tgt,limit=1] at @s facing entity @p[tag=kitpvp.mo_tgt,limit=1] feet run tp @s ^ ^ ^0.9
# 垂直：mo_vy 从 10 递减到负数，分档给位移（1.20.1 没数学函数，除法做不了，就查表）
execute if score @s kitpvp.mo_vy matches 9.. run tp @s ~ ~0.8 ~
execute if score @s kitpvp.mo_vy matches 7..8 run tp @s ~ ~0.65 ~
execute if score @s kitpvp.mo_vy matches 5..6 run tp @s ~ ~0.5 ~
execute if score @s kitpvp.mo_vy matches 3..4 run tp @s ~ ~0.35 ~
execute if score @s kitpvp.mo_vy matches 1..2 run tp @s ~ ~0.2 ~
execute if score @s kitpvp.mo_vy matches -1..0 run tp @s ~ ~-0.05 ~
execute if score @s kitpvp.mo_vy matches -3..-2 run tp @s ~ ~-0.35 ~
execute if score @s kitpvp.mo_vy matches -5..-4 run tp @s ~ ~-0.6 ~
execute if score @s kitpvp.mo_vy matches -7..-6 run tp @s ~ ~-0.85 ~
execute if score @s kitpvp.mo_vy matches ..-8 run tp @s ~ ~-1.1 ~
scoreboard players remove @s kitpvp.mo_vy 1
# 引爆：贴到目标 2 格内，或者飞满 2 秒（40 刻）兜底
execute if entity @p[tag=kitpvp.mo_tgt,distance=..2] run function kitpvp:skill/earth/mortar_burst
execute if score @s kitpvp.mo_life matches 40.. run function kitpvp:skill/earth/mortar_burst
