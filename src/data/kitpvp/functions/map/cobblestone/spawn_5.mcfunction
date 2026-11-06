# 出生点 5/7 = (23,61,-4956)：F
tp @s 23 61 -4956
spawnpoint @s 23 61 -4956
scoreboard players set @s kitpvp.spawn_slot 5
execute at @s run summon minecraft:marker ~ ~ ~ {Tags:["kitpvp.spawn_anchor","kitpvp.spawn_anchor.5"]}
tag @s add kitpvp.spawn_assigned
scoreboard players add #cur kitpvp.tmp 1
execute if score #cur kitpvp.tmp matches 8.. run scoreboard players set #cur kitpvp.tmp 1
