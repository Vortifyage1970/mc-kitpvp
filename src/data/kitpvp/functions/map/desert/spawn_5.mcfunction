# 沙漠出生点 5（改坐标改下面两行）
tp @s -311 93 -24
spawnpoint @s -311 93 -24
tag @s add kitpvp.spawn_assigned
scoreboard players add #cur kitpvp.tmp 1
execute if score #cur kitpvp.tmp matches 10.. run scoreboard players set #cur kitpvp.tmp 1
