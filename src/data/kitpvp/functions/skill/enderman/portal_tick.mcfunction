# @s = 传送门 marker（每刻被 tick 调一次）：寿命、粒子、到期消失
execute if score @s kitpvp.tep_life matches 1.. run scoreboard players remove @s kitpvp.tep_life 1
execute unless score @s kitpvp.tep_life matches 1.. run function kitpvp:skill/enderman/portal_close
execute if entity @s[tag=kitpvp.tep_a] run particle minecraft:flame ~ ~0.9 ~ 0.2 0.85 0.2 0.01 2 normal
execute if entity @s[tag=kitpvp.tep_b] run particle minecraft:soul_fire_flame ~ ~0.9 ~ 0.2 0.85 0.2 0.01 2 normal
