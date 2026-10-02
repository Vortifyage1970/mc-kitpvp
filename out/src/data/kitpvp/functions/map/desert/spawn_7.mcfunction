# 沙漠出生点 7（改坐标只改下面这行）
tp @s -364 106 -31
spawnpoint @s
tag @s add kitpvp.spawn_assigned
scoreboard players add #cur kitpvp.tmp 1
execute if score #cur kitpvp.tmp matches 10.. run scoreboard players set #cur kitpvp.tmp 1
