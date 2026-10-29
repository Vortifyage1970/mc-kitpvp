# 女巫蛋在本服只有本职业发
execute if score @s kitpvp.cd2 matches ..0 if entity @e[type=minecraft:witch,tag=kitpvp.tt_spawn_witch,distance=..8] at @e[type=minecraft:witch,tag=kitpvp.tt_spawn_witch,distance=..8,sort=nearest,limit=1] run function kitpvp:summon/tainted_tamer_witch
execute if score @s kitpvp.cd2 matches ..0 if entity @e[type=minecraft:witch,tag=kitpvp.tt_spawn_witch,distance=..8] run function kitpvp:skill/tainted_tamer/start_cd2
kill @e[type=minecraft:witch,tag=kitpvp.tt_spawn_witch,distance=..8]
