# 核弹：技能 4 一次性给 4 枚，没有补货计时（用一枚少一枚）
execute at @e[type=minecraft:mooshroom,tag=kitpvp.bomb_nuke_token,distance=..16,sort=nearest,limit=1] run function kitpvp:summon/bomber_nuke
execute at @s run kill @e[type=minecraft:mooshroom,tag=kitpvp.bomb_nuke_token,distance=..16]
