# 出生点 2/7 = (-27,63,-5024)：B
tp @s -27 63 -5024
spawnpoint @s -27 63 -5024
scoreboard players set @s kitpvp.spawn_slot 2
execute at @s run summon minecraft:marker ~ ~ ~ {Tags:["kitpvp.spawn_anchor","kitpvp.spawn_anchor.2"]}
tag @s add kitpvp.spawn_assigned
scoreboard players add #cur kitpvp.tmp 1
execute if score #cur kitpvp.tmp matches 8.. run scoreboard players set #cur kitpvp.tmp 1
