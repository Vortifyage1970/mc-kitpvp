# 核弹：独立 12 秒（240 刻）补货，不占技能组 1 的补货计时
execute if score @s kitpvp.bomb_nuke_cd matches ..0 run scoreboard players set @s kitpvp.bomb_nuke_cd 240
execute at @e[type=minecraft:mooshroom,tag=kitpvp.bomb_nuke_token,distance=..16,sort=nearest,limit=1] run function kitpvp:summon/bomber_nuke
execute at @s run kill @e[type=minecraft:mooshroom,tag=kitpvp.bomb_nuke_token,distance=..16]
