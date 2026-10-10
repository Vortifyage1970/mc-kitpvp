# 地球出生点 9（改坐标改下面两行）
tp @s -680 90 -675
spawnpoint @s -680 90 -675
tag @s add kitpvp.spawn_assigned
scoreboard players add #cur kitpvp.tmp 1
execute if score #cur kitpvp.tmp matches 10.. run scoreboard players set #cur kitpvp.tmp 1
