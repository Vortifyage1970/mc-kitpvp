# 烈焰人蛋与战士魂石、里·弓箭手熔火核心共用统计，只有带 kitpvp.tt_spawn_blaze 的那只才是本职业的（见 spawn_zombie）
execute if score @s kitpvp.cd2 matches ..0 if entity @e[type=minecraft:blaze,tag=kitpvp.tt_spawn_blaze,distance=..8] at @e[type=minecraft:blaze,tag=kitpvp.tt_spawn_blaze,distance=..8,sort=nearest,limit=1] run function kitpvp:summon/tainted_tamer_blaze
execute if score @s kitpvp.cd2 matches ..0 if entity @e[type=minecraft:blaze,tag=kitpvp.tt_spawn_blaze,distance=..8] run function kitpvp:skill/tainted_tamer/start_cd2
kill @e[type=minecraft:blaze,tag=kitpvp.tt_spawn_blaze,distance=..8]
