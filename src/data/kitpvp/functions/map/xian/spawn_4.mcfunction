# 西安出生点 4（改坐标改下面两行）
tp @s -1230 64 -695
spawnpoint @s -1230 64 -695
tag @s add kitpvp.spawn_assigned
scoreboard players add #cur kitpvp.tmp 1
execute if score #cur kitpvp.tmp matches 7.. run scoreboard players set #cur kitpvp.tmp 1
