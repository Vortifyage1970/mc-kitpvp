# 出手：重置冷却，有人就打
scoreboard players set @s kitpvp.snow_cd 40
execute if entity @p[distance=..15,gamemode=!spectator] run function kitpvp:debug/snow_shoot
