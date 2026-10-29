# 苦力怕蛋在本服只有本职业发（见 spawn_zombie）
execute if score @s kitpvp.cd matches ..0 if entity @e[type=minecraft:creeper,tag=kitpvp.tt_spawn_creeper,distance=..8] at @e[type=minecraft:creeper,tag=kitpvp.tt_spawn_creeper,distance=..8,sort=nearest,limit=1] run function kitpvp:summon/tainted_tamer_creeper
execute if score @s kitpvp.cd matches ..0 if entity @e[type=minecraft:creeper,tag=kitpvp.tt_spawn_creeper,distance=..8] run function kitpvp:skill/tainted_tamer/start_cd1
kill @e[type=minecraft:creeper,tag=kitpvp.tt_spawn_creeper,distance=..8]
