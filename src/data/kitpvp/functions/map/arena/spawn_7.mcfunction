# 竞技场出生点 7（改坐标改下面两行）
tp @s 527 69 527
spawnpoint @s 527 69 527
tag @s add kitpvp.spawn_assigned
scoreboard players add #cur kitpvp.tmp 1
execute if score #cur kitpvp.tmp matches 10.. run scoreboard players set #cur kitpvp.tmp 1
