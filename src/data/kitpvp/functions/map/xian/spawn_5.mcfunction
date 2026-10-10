# 西安出生点 5（改坐标改下面两行）
tp @s -1200 64 -700
spawnpoint @s -1200 64 -700
tag @s add kitpvp.spawn_assigned
scoreboard players add #cur kitpvp.tmp 1
execute if score #cur kitpvp.tmp matches 7.. run scoreboard players set #cur kitpvp.tmp 1
