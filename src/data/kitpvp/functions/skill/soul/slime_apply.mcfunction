# 20 秒：表史莱姆的常驻跳跃提升 III + 速度 I，加上里·史莱姆的蓄力火箭跳
# 增益只发这一次（不每刻补）；蓄力会临时用更高等级占住跳跃提升这一格
tag @s add kitpvp.soul_slime_active
tag @s add kitpvp.rocket_jump

scoreboard players set @s kitpvp.soul_slime_timer 400
scoreboard players set @s kitpvp.rocket_charge 0

effect give @s minecraft:jump_boost 20 2 true
effect give @s minecraft:speed 20 0 true

title @s actionbar {"text":"魂石·蓄力：跳跃提升 III + 速度 I + 蓄力火箭跳（20 秒）","color":"green"}
playsound minecraft:item.totem.use master @s ~ ~ ~ 0.6 1.0
