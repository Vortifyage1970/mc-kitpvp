# 串联体光环：以"每一对"为单位处理
# @s = 那一对的僵尸底座；触发半径 8 格（要比 4 格宽，否则你在 5 格外就什么效果都看不到）
execute at @s at @p[distance=..8,gamemode=!spectator,tag=!kitpvp.spectator,nbt=!{Health:0.0f},sort=nearest] run function kitpvp:skill/earth/tandem_pick
scoreboard players set @s kitpvp.earth_cd_a 20
