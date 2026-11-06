# 串联体光环：以"每一对"为单位处理
# @s = 那一对的僵尸底座；先挑 4 格内最近的活人，再在那个人的位置里分近/远
execute at @s at @p[distance=..4,gamemode=!spectator,tag=!kitpvp.spectator,nbt=!{Health:0.0f},sort=nearest] run function kitpvp:skill/earth/tanden_pick
scoreboard players set @s kitpvp.earth_cd_a 60
