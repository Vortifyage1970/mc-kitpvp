# 地球出生点 5（改坐标改下面两行）
tp @s -674 97 -676
spawnpoint @s -674 97 -676
tag @s add kitpvp.spawn_assigned
scoreboard players add #cur kitpvp.tmp 1
execute if score #cur kitpvp.tmp matches 10.. run scoreboard players set #cur kitpvp.tmp 1
