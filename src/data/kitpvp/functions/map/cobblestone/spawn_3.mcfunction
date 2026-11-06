# 出生点 3/7 = (-8,61,-4954)：E
tp @s -8 61 -4954
spawnpoint @s -8 61 -4954
scoreboard players set @s kitpvp.spawn_slot 3
execute at @s run summon minecraft:marker ~ ~ ~ {Tags:["kitpvp.spawn_anchor","kitpvp.spawn_anchor.3"]}
tag @s add kitpvp.spawn_assigned
scoreboard players add #cur kitpvp.tmp 1
execute if score #cur kitpvp.tmp matches 8.. run scoreboard players set #cur kitpvp.tmp 1
