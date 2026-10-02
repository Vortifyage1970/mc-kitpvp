# 沙漠出生点 1（改坐标只改下面这行）
tp @s -363 90 -81
spawnpoint @s
tag @s add kitpvp.spawn_assigned
scoreboard players add #cur kitpvp.tmp 1
execute if score #cur kitpvp.tmp matches 10.. run scoreboard players set #cur kitpvp.tmp 1
