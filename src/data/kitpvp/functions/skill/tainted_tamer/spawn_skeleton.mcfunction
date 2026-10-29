# 骷髅蛋与弓箭手魂石共用统计，只有带 kitpvp.tt_spawn_skeleton 的那只才是本职业的（见 spawn_zombie）
execute if score @s kitpvp.cd matches ..0 if entity @e[type=minecraft:skeleton,tag=kitpvp.tt_spawn_skeleton,distance=..8] at @e[type=minecraft:skeleton,tag=kitpvp.tt_spawn_skeleton,distance=..8,sort=nearest,limit=1] run function kitpvp:summon/tainted_tamer_skeleton
execute if score @s kitpvp.cd matches ..0 if entity @e[type=minecraft:skeleton,tag=kitpvp.tt_spawn_skeleton,distance=..8] run function kitpvp:skill/tainted_tamer/start_cd1
kill @e[type=minecraft:skeleton,tag=kitpvp.tt_spawn_skeleton,distance=..8]
