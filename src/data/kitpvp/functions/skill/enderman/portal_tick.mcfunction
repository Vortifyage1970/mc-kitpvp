# @s = 传送门 marker（每刻被 tick 调一次）：寿命、进度条、粒子、到期消失
execute if score @s kitpvp.tep_life matches 1.. run scoreboard players remove @s kitpvp.tep_life 1
execute unless score @s kitpvp.tep_life matches 1.. run function kitpvp:skill/enderman/portal_close

# bossbar 的 value 只能是字面量、不能读分数：按 2 秒一档写死 10 档，实心部分随时间等比例缩回
execute if entity @s[tag=kitpvp.tep_a] if score @s kitpvp.tep_life matches 361..400 run bossbar set kitpvp:tep_hud_orange value 100
execute if entity @s[tag=kitpvp.tep_a] if score @s kitpvp.tep_life matches 321..360 run bossbar set kitpvp:tep_hud_orange value 90
execute if entity @s[tag=kitpvp.tep_a] if score @s kitpvp.tep_life matches 281..320 run bossbar set kitpvp:tep_hud_orange value 80
execute if entity @s[tag=kitpvp.tep_a] if score @s kitpvp.tep_life matches 241..280 run bossbar set kitpvp:tep_hud_orange value 70
execute if entity @s[tag=kitpvp.tep_a] if score @s kitpvp.tep_life matches 201..240 run bossbar set kitpvp:tep_hud_orange value 60
execute if entity @s[tag=kitpvp.tep_a] if score @s kitpvp.tep_life matches 161..200 run bossbar set kitpvp:tep_hud_orange value 50
execute if entity @s[tag=kitpvp.tep_a] if score @s kitpvp.tep_life matches 121..160 run bossbar set kitpvp:tep_hud_orange value 40
execute if entity @s[tag=kitpvp.tep_a] if score @s kitpvp.tep_life matches 81..120 run bossbar set kitpvp:tep_hud_orange value 30
execute if entity @s[tag=kitpvp.tep_a] if score @s kitpvp.tep_life matches 41..80 run bossbar set kitpvp:tep_hud_orange value 20
execute if entity @s[tag=kitpvp.tep_a] if score @s kitpvp.tep_life matches 1..40 run bossbar set kitpvp:tep_hud_orange value 10
execute if entity @s[tag=kitpvp.tep_b] if score @s kitpvp.tep_life matches 361..400 run bossbar set kitpvp:tep_hud_blue value 100
execute if entity @s[tag=kitpvp.tep_b] if score @s kitpvp.tep_life matches 321..360 run bossbar set kitpvp:tep_hud_blue value 90
execute if entity @s[tag=kitpvp.tep_b] if score @s kitpvp.tep_life matches 281..320 run bossbar set kitpvp:tep_hud_blue value 80
execute if entity @s[tag=kitpvp.tep_b] if score @s kitpvp.tep_life matches 241..280 run bossbar set kitpvp:tep_hud_blue value 70
execute if entity @s[tag=kitpvp.tep_b] if score @s kitpvp.tep_life matches 201..240 run bossbar set kitpvp:tep_hud_blue value 60
execute if entity @s[tag=kitpvp.tep_b] if score @s kitpvp.tep_life matches 161..200 run bossbar set kitpvp:tep_hud_blue value 50
execute if entity @s[tag=kitpvp.tep_b] if score @s kitpvp.tep_life matches 121..160 run bossbar set kitpvp:tep_hud_blue value 40
execute if entity @s[tag=kitpvp.tep_b] if score @s kitpvp.tep_life matches 81..120 run bossbar set kitpvp:tep_hud_blue value 30
execute if entity @s[tag=kitpvp.tep_b] if score @s kitpvp.tep_life matches 41..80 run bossbar set kitpvp:tep_hud_blue value 20
execute if entity @s[tag=kitpvp.tep_b] if score @s kitpvp.tep_life matches 1..40 run bossbar set kitpvp:tep_hud_blue value 10

execute if entity @s[tag=kitpvp.tep_a] run particle minecraft:flame ~ ~0.9 ~ 0.2 0.85 0.2 0.01 2 normal
execute if entity @s[tag=kitpvp.tep_b] run particle minecraft:soul_fire_flame ~ ~0.9 ~ 0.2 0.85 0.2 0.01 2 normal
