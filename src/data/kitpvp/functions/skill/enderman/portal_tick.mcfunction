# @s = 传送门 marker（每刻被 tick 调一次）：寿命、粒子、到期消失
execute if score @s kitpvp.tep_life matches 1.. run scoreboard players remove @s kitpvp.tep_life 1
execute unless score @s kitpvp.tep_life matches 1.. run function kitpvp:skill/enderman/portal_close
execute if entity @s[tag=kitpvp.tep_a] run particle minecraft:flame ~ ~0.9 ~ 0.24 0.9 0.24 0.01 3 normal
execute if entity @s[tag=kitpvp.tep_b] run particle minecraft:soul_fire_flame ~ ~0.9 ~ 0.24 0.9 0.24 0.01 3 normal
execute if entity @s[tag=kitpvp.tep_a] run particle minecraft:lava ~ ~0.9 ~ 0.3 0.9 0.3 0 1 normal
execute if entity @s[tag=kitpvp.tep_b] run particle minecraft:end_rod ~ ~0.9 ~ 0.3 0.9 0.3 0.01 2 normal
execute unless score @s kitpvp.tep_life matches 1.. run playsound minecraft:block.end_portal_frame.break master @a[distance=..16] ~ ~ ~ 0.6 1.2
