# 技能组 2 的四枚：卫道士蛋在本服只有本职业发（其余三枚见 spawn_skeleton / spawn_vex / spawn_blaze 的分流说明）
execute if score @s kitpvp.cd2 matches ..0 if entity @e[type=minecraft:vindicator,tag=kitpvp.tt_spawn_vindicator,distance=..8] at @e[type=minecraft:vindicator,tag=kitpvp.tt_spawn_vindicator,distance=..8,sort=nearest,limit=1] run function kitpvp:summon/tainted_tamer_vindicator
execute if score @s kitpvp.cd2 matches ..0 if entity @e[type=minecraft:vindicator,tag=kitpvp.tt_spawn_vindicator,distance=..8] run function kitpvp:skill/tainted_tamer/start_cd2
kill @e[type=minecraft:vindicator,tag=kitpvp.tt_spawn_vindicator,distance=..8]
