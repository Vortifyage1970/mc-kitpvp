tp @s -6979 68 -7018
spawnpoint @s -6979 68 -7018
scoreboard players set @s kitpvp.spawn_slot 3
execute at @s run summon minecraft:marker ~ ~ ~ {Tags:["kitpvp.spawn_anchor","kitpvp.spawn_anchor.3"]}
tag @s add kitpvp.spawn_assigned
scoreboard players add #cur kitpvp.tmp 1
execute if score #cur kitpvp.tmp matches 9.. run scoreboard players set #cur kitpvp.tmp 1
