# 无重力召唤物的移动层：无重力僵尸（earth_zerog）、泥土骑士的蠹虫（earth_dirtknight）
# 它们 NoGravity ⇒ onGround 恒 false ⇒ 地面寻路不跑，只能每刻 tp 硬拖
execute as @e[tag=kitpvp.earth_zerog] at @s run function kitpvp:skill/earth/nograv_step
execute as @e[tag=kitpvp.earth_dirtknight] at @s run function kitpvp:skill/earth/nograv_step