# 到期只摘激活标记、复位召唤冷却（隐身交给原版计时器）
tag @s remove kitpvp.soul_ghost_active
scoreboard players set @s kitpvp.ghost_minion_cd 0
effect clear @e[type=skeleton,tag=kitpvp.ghost_minion]
