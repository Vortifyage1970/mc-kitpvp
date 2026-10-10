# 西安出生点 1（改坐标改下面两行）
tp @s -1203 64 -716
spawnpoint @s -1203 64 -716
tag @s add kitpvp.spawn_assigned
scoreboard players add #cur kitpvp.tmp 1
execute if score #cur kitpvp.tmp matches 7.. run scoreboard players set #cur kitpvp.tmp 1
