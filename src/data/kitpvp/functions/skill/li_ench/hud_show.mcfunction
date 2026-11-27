# 算出两条的值，再挂到自己那条槽位上
function kitpvp:skill/li_ench/hud_calc
execute if score @s kitpvp.ench_slot matches 1 run bossbar set kitpvp:li_s1 players @s
execute if score @s kitpvp.ench_slot matches 1 run bossbar set kitpvp:li_a1 players @s
execute if score @s kitpvp.ench_slot matches 2 run bossbar set kitpvp:li_s2 players @s
execute if score @s kitpvp.ench_slot matches 2 run bossbar set kitpvp:li_a2 players @s
execute if score @s kitpvp.ench_slot matches 3 run bossbar set kitpvp:li_s3 players @s
execute if score @s kitpvp.ench_slot matches 3 run bossbar set kitpvp:li_a3 players @s
execute if score @s kitpvp.ench_slot matches 4 run bossbar set kitpvp:li_s4 players @s
execute if score @s kitpvp.ench_slot matches 4 run bossbar set kitpvp:li_a4 players @s
execute if score @s kitpvp.ench_slot matches 5 run bossbar set kitpvp:li_s5 players @s
execute if score @s kitpvp.ench_slot matches 5 run bossbar set kitpvp:li_a5 players @s
execute if score @s kitpvp.ench_slot matches 6 run bossbar set kitpvp:li_s6 players @s
execute if score @s kitpvp.ench_slot matches 6 run bossbar set kitpvp:li_a6 players @s
execute if score @s kitpvp.ench_slot matches 7 run bossbar set kitpvp:li_s7 players @s
execute if score @s kitpvp.ench_slot matches 7 run bossbar set kitpvp:li_a7 players @s
execute if score @s kitpvp.ench_slot matches 8 run bossbar set kitpvp:li_s8 players @s
execute if score @s kitpvp.ench_slot matches 8 run bossbar set kitpvp:li_a8 players @s
execute if score @s kitpvp.ench_slot matches 1 run execute store result bossbar kitpvp:li_s1 value run scoreboard players get #hud_s kitpvp.game
execute if score @s kitpvp.ench_slot matches 1 run execute store result bossbar kitpvp:li_a1 value run scoreboard players get #hud_a kitpvp.game
execute if score @s kitpvp.ench_slot matches 2 run execute store result bossbar kitpvp:li_s2 value run scoreboard players get #hud_s kitpvp.game
execute if score @s kitpvp.ench_slot matches 2 run execute store result bossbar kitpvp:li_a2 value run scoreboard players get #hud_a kitpvp.game
execute if score @s kitpvp.ench_slot matches 3 run execute store result bossbar kitpvp:li_s3 value run scoreboard players get #hud_s kitpvp.game
execute if score @s kitpvp.ench_slot matches 3 run execute store result bossbar kitpvp:li_a3 value run scoreboard players get #hud_a kitpvp.game
execute if score @s kitpvp.ench_slot matches 4 run execute store result bossbar kitpvp:li_s4 value run scoreboard players get #hud_s kitpvp.game
execute if score @s kitpvp.ench_slot matches 4 run execute store result bossbar kitpvp:li_a4 value run scoreboard players get #hud_a kitpvp.game
execute if score @s kitpvp.ench_slot matches 5 run execute store result bossbar kitpvp:li_s5 value run scoreboard players get #hud_s kitpvp.game
execute if score @s kitpvp.ench_slot matches 5 run execute store result bossbar kitpvp:li_a5 value run scoreboard players get #hud_a kitpvp.game
execute if score @s kitpvp.ench_slot matches 6 run execute store result bossbar kitpvp:li_s6 value run scoreboard players get #hud_s kitpvp.game
execute if score @s kitpvp.ench_slot matches 6 run execute store result bossbar kitpvp:li_a6 value run scoreboard players get #hud_a kitpvp.game
execute if score @s kitpvp.ench_slot matches 7 run execute store result bossbar kitpvp:li_s7 value run scoreboard players get #hud_s kitpvp.game
execute if score @s kitpvp.ench_slot matches 7 run execute store result bossbar kitpvp:li_a7 value run scoreboard players get #hud_a kitpvp.game
execute if score @s kitpvp.ench_slot matches 8 run execute store result bossbar kitpvp:li_s8 value run scoreboard players get #hud_s kitpvp.game
execute if score @s kitpvp.ench_slot matches 8 run execute store result bossbar kitpvp:li_a8 value run scoreboard players get #hud_a kitpvp.game
execute if score @s kitpvp.ench_slot matches 1 if score @s kitpvp.ench_sword matches ..10 run bossbar set kitpvp:li_s1 color purple
execute if score @s kitpvp.ench_slot matches 1 if score @s kitpvp.ench_sword matches 11.. run bossbar set kitpvp:li_s1 color yellow
execute if score @s kitpvp.ench_slot matches 1 if score @s kitpvp.ench_armor matches ..10 run bossbar set kitpvp:li_a1 color blue
execute if score @s kitpvp.ench_slot matches 1 if score @s kitpvp.ench_armor matches 11.. run bossbar set kitpvp:li_a1 color yellow
execute if score @s kitpvp.ench_slot matches 2 if score @s kitpvp.ench_sword matches ..10 run bossbar set kitpvp:li_s2 color purple
execute if score @s kitpvp.ench_slot matches 2 if score @s kitpvp.ench_sword matches 11.. run bossbar set kitpvp:li_s2 color yellow
execute if score @s kitpvp.ench_slot matches 2 if score @s kitpvp.ench_armor matches ..10 run bossbar set kitpvp:li_a2 color blue
execute if score @s kitpvp.ench_slot matches 2 if score @s kitpvp.ench_armor matches 11.. run bossbar set kitpvp:li_a2 color yellow
execute if score @s kitpvp.ench_slot matches 3 if score @s kitpvp.ench_sword matches ..10 run bossbar set kitpvp:li_s3 color purple
execute if score @s kitpvp.ench_slot matches 3 if score @s kitpvp.ench_sword matches 11.. run bossbar set kitpvp:li_s3 color yellow
execute if score @s kitpvp.ench_slot matches 3 if score @s kitpvp.ench_armor matches ..10 run bossbar set kitpvp:li_a3 color blue
execute if score @s kitpvp.ench_slot matches 3 if score @s kitpvp.ench_armor matches 11.. run bossbar set kitpvp:li_a3 color yellow
execute if score @s kitpvp.ench_slot matches 4 if score @s kitpvp.ench_sword matches ..10 run bossbar set kitpvp:li_s4 color purple
execute if score @s kitpvp.ench_slot matches 4 if score @s kitpvp.ench_sword matches 11.. run bossbar set kitpvp:li_s4 color yellow
execute if score @s kitpvp.ench_slot matches 4 if score @s kitpvp.ench_armor matches ..10 run bossbar set kitpvp:li_a4 color blue
execute if score @s kitpvp.ench_slot matches 4 if score @s kitpvp.ench_armor matches 11.. run bossbar set kitpvp:li_a4 color yellow
execute if score @s kitpvp.ench_slot matches 5 if score @s kitpvp.ench_sword matches ..10 run bossbar set kitpvp:li_s5 color purple
execute if score @s kitpvp.ench_slot matches 5 if score @s kitpvp.ench_sword matches 11.. run bossbar set kitpvp:li_s5 color yellow
execute if score @s kitpvp.ench_slot matches 5 if score @s kitpvp.ench_armor matches ..10 run bossbar set kitpvp:li_a5 color blue
execute if score @s kitpvp.ench_slot matches 5 if score @s kitpvp.ench_armor matches 11.. run bossbar set kitpvp:li_a5 color yellow
execute if score @s kitpvp.ench_slot matches 6 if score @s kitpvp.ench_sword matches ..10 run bossbar set kitpvp:li_s6 color purple
execute if score @s kitpvp.ench_slot matches 6 if score @s kitpvp.ench_sword matches 11.. run bossbar set kitpvp:li_s6 color yellow
execute if score @s kitpvp.ench_slot matches 6 if score @s kitpvp.ench_armor matches ..10 run bossbar set kitpvp:li_a6 color blue
execute if score @s kitpvp.ench_slot matches 6 if score @s kitpvp.ench_armor matches 11.. run bossbar set kitpvp:li_a6 color yellow
execute if score @s kitpvp.ench_slot matches 7 if score @s kitpvp.ench_sword matches ..10 run bossbar set kitpvp:li_s7 color purple
execute if score @s kitpvp.ench_slot matches 7 if score @s kitpvp.ench_sword matches 11.. run bossbar set kitpvp:li_s7 color yellow
execute if score @s kitpvp.ench_slot matches 7 if score @s kitpvp.ench_armor matches ..10 run bossbar set kitpvp:li_a7 color blue
execute if score @s kitpvp.ench_slot matches 7 if score @s kitpvp.ench_armor matches 11.. run bossbar set kitpvp:li_a7 color yellow
execute if score @s kitpvp.ench_slot matches 8 if score @s kitpvp.ench_sword matches ..10 run bossbar set kitpvp:li_s8 color purple
execute if score @s kitpvp.ench_slot matches 8 if score @s kitpvp.ench_sword matches 11.. run bossbar set kitpvp:li_s8 color yellow
execute if score @s kitpvp.ench_slot matches 8 if score @s kitpvp.ench_armor matches ..10 run bossbar set kitpvp:li_a8 color blue
execute if score @s kitpvp.ench_slot matches 8 if score @s kitpvp.ench_armor matches 11.. run bossbar set kitpvp:li_a8 color yellow
