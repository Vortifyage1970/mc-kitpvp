# 算出两条的值，再挂到自己那条槽位上
function kitpvp:skill/enchanter/hud_calc
execute if score @s kitpvp.ench_slot matches 1 run bossbar set kitpvp:ench_s1 players @s
execute if score @s kitpvp.ench_slot matches 1 run bossbar set kitpvp:ench_a1 players @s
execute if score @s kitpvp.ench_slot matches 2 run bossbar set kitpvp:ench_s2 players @s
execute if score @s kitpvp.ench_slot matches 2 run bossbar set kitpvp:ench_a2 players @s
execute if score @s kitpvp.ench_slot matches 3 run bossbar set kitpvp:ench_s3 players @s
execute if score @s kitpvp.ench_slot matches 3 run bossbar set kitpvp:ench_a3 players @s
execute if score @s kitpvp.ench_slot matches 4 run bossbar set kitpvp:ench_s4 players @s
execute if score @s kitpvp.ench_slot matches 4 run bossbar set kitpvp:ench_a4 players @s
execute if score @s kitpvp.ench_slot matches 5 run bossbar set kitpvp:ench_s5 players @s
execute if score @s kitpvp.ench_slot matches 5 run bossbar set kitpvp:ench_a5 players @s
execute if score @s kitpvp.ench_slot matches 6 run bossbar set kitpvp:ench_s6 players @s
execute if score @s kitpvp.ench_slot matches 6 run bossbar set kitpvp:ench_a6 players @s
execute if score @s kitpvp.ench_slot matches 7 run bossbar set kitpvp:ench_s7 players @s
execute if score @s kitpvp.ench_slot matches 7 run bossbar set kitpvp:ench_a7 players @s
execute if score @s kitpvp.ench_slot matches 8 run bossbar set kitpvp:ench_s8 players @s
execute if score @s kitpvp.ench_slot matches 8 run bossbar set kitpvp:ench_a8 players @s
execute if score @s kitpvp.ench_slot matches 1 run execute store result bossbar kitpvp:ench_s1 value run scoreboard players get #hud_s kitpvp.game
execute if score @s kitpvp.ench_slot matches 1 run execute store result bossbar kitpvp:ench_a1 value run scoreboard players get #hud_a kitpvp.game
execute if score @s kitpvp.ench_slot matches 2 run execute store result bossbar kitpvp:ench_s2 value run scoreboard players get #hud_s kitpvp.game
execute if score @s kitpvp.ench_slot matches 2 run execute store result bossbar kitpvp:ench_a2 value run scoreboard players get #hud_a kitpvp.game
execute if score @s kitpvp.ench_slot matches 3 run execute store result bossbar kitpvp:ench_s3 value run scoreboard players get #hud_s kitpvp.game
execute if score @s kitpvp.ench_slot matches 3 run execute store result bossbar kitpvp:ench_a3 value run scoreboard players get #hud_a kitpvp.game
execute if score @s kitpvp.ench_slot matches 4 run execute store result bossbar kitpvp:ench_s4 value run scoreboard players get #hud_s kitpvp.game
execute if score @s kitpvp.ench_slot matches 4 run execute store result bossbar kitpvp:ench_a4 value run scoreboard players get #hud_a kitpvp.game
execute if score @s kitpvp.ench_slot matches 5 run execute store result bossbar kitpvp:ench_s5 value run scoreboard players get #hud_s kitpvp.game
execute if score @s kitpvp.ench_slot matches 5 run execute store result bossbar kitpvp:ench_a5 value run scoreboard players get #hud_a kitpvp.game
execute if score @s kitpvp.ench_slot matches 6 run execute store result bossbar kitpvp:ench_s6 value run scoreboard players get #hud_s kitpvp.game
execute if score @s kitpvp.ench_slot matches 6 run execute store result bossbar kitpvp:ench_a6 value run scoreboard players get #hud_a kitpvp.game
execute if score @s kitpvp.ench_slot matches 7 run execute store result bossbar kitpvp:ench_s7 value run scoreboard players get #hud_s kitpvp.game
execute if score @s kitpvp.ench_slot matches 7 run execute store result bossbar kitpvp:ench_a7 value run scoreboard players get #hud_a kitpvp.game
execute if score @s kitpvp.ench_slot matches 8 run execute store result bossbar kitpvp:ench_s8 value run scoreboard players get #hud_s kitpvp.game
execute if score @s kitpvp.ench_slot matches 8 run execute store result bossbar kitpvp:ench_a8 value run scoreboard players get #hud_a kitpvp.game
