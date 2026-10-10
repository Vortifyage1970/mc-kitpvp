# 地球出生点 3（改坐标改下面两行）
tp @s -664 93 -658
spawnpoint @s -664 93 -658
tag @s add kitpvp.spawn_assigned
scoreboard players add #cur kitpvp.tmp 1
execute if score #cur kitpvp.tmp matches 10.. run scoreboard players set #cur kitpvp.tmp 1
