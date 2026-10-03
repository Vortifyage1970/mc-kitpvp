# 沙漠出生点 4（改坐标改下面两行）
tp @s -321 86 -49
spawnpoint @s -321 86 -49
tag @s add kitpvp.spawn_assigned
scoreboard players add #cur kitpvp.tmp 1
execute if score #cur kitpvp.tmp matches 10.. run scoreboard players set #cur kitpvp.tmp 1
