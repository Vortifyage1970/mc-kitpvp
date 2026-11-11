# 跟踪炸弹：上限 1，用掉后 30 秒（600 刻）补回
execute if score @s kitpvp.bomb_track_cd matches ..0 run scoreboard players set @s kitpvp.bomb_track_cd 600
execute at @e[type=minecraft:mooshroom,tag=kitpvp.bomb_track_token,distance=..16,sort=nearest,limit=1] run function kitpvp:summon/bomber_track
execute at @s run kill @e[type=minecraft:mooshroom,tag=kitpvp.bomb_track_token,distance=..16]
