# 无重力召唤物的移动层：深池飞行兵的蠹虫（earth_dublinn）
# 它们 NoGravity ⇒ onGround 恒 false ⇒ 地面寻路不跑，只能每刻 tp 硬拖
execute as @e[tag=kitpvp.earth_dublinn] at @s run function kitpvp:skill/earth/nograv_step