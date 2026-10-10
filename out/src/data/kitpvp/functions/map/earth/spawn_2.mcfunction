# 地球出生点 2（改坐标改下面两行）
tp @s -648 88 -651
spawnpoint @s -648 89 -651
tag @s add kitpvp.spawn_assigned
scoreboard players add #cur kitpvp.tmp 1
execute if score #cur kitpvp.tmp matches 10.. run scoreboard players set #cur kitpvp.tmp 1
