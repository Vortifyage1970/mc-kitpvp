# @s = 飞龙宝宝：数冷却，到 0 且 20 格内有活人就吐一发
scoreboard players remove @s kitpvp.bw_cd 1
execute if score @s kitpvp.bw_cd matches ..0 if entity @p[distance=..20,gamemode=!spectator,gamemode=!creative,tag=!kitpvp.spectator] run function kitpvp:skill/earth/babywhelp_fire
