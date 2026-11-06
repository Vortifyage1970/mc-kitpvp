# 出生点 1/7 = (30,62,-4977)：A。编号相邻的都尽量远（相邻最小 46.6 格，见 04 §七.6）
tp @s 30 62 -4977
spawnpoint @s 30 62 -4977
scoreboard players set @s kitpvp.spawn_slot 1
execute at @s run summon minecraft:marker ~ ~ ~ {Tags:["kitpvp.spawn_anchor","kitpvp.spawn_anchor.1"]}
tag @s add kitpvp.spawn_assigned
scoreboard players add #cur kitpvp.tmp 1
execute if score #cur kitpvp.tmp matches 8.. run scoreboard players set #cur kitpvp.tmp 1
