# 西安出生点 2（改坐标改下面两行）
tp @s -1222 65 -712
spawnpoint @s -1222 65 -712
tag @s add kitpvp.spawn_assigned
scoreboard players add #cur kitpvp.tmp 1
execute if score #cur kitpvp.tmp matches 7.. run scoreboard players set #cur kitpvp.tmp 1
