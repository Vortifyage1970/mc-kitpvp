# 技能组 1（cd，15 秒）：先按"哪一枚蛋真的用掉了"分流，最后无条件把三个快照推平（见 05 §12）
# 三枚蛋共用一套冷却：任何一枚用掉，start_cd1 会把其余两枚一并收走
execute if score @s kitpvp.ttamer_zombie_used > @s kitpvp.ttamer_zombie_last run function kitpvp:skill/tainted_tamer/spawn_zombie
execute if score @s kitpvp.ttamer_skeleton_used > @s kitpvp.ttamer_skeleton_last run function kitpvp:skill/tainted_tamer/spawn_skeleton
execute if score @s kitpvp.ttamer_creeper_used > @s kitpvp.ttamer_creeper_last run function kitpvp:skill/tainted_tamer/spawn_creeper

scoreboard players operation @s kitpvp.ttamer_zombie_last = @s kitpvp.ttamer_zombie_used
scoreboard players operation @s kitpvp.ttamer_skeleton_last = @s kitpvp.ttamer_skeleton_used
scoreboard players operation @s kitpvp.ttamer_creeper_last = @s kitpvp.ttamer_creeper_used
