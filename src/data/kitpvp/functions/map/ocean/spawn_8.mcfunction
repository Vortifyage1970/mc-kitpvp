tp @s -6997 63 -7019
spawnpoint @s -6997 63 -7019
scoreboard players set @s kitpvp.spawn_slot 8
execute at @s run summon minecraft:marker ~ ~ ~ {Tags:["kitpvp.spawn_anchor","kitpvp.spawn_anchor.8"]}
tag @s add kitpvp.spawn_assigned
scoreboard players add #cur kitpvp.tmp 1
execute if score #cur kitpvp.tmp matches 9.. run scoreboard players set #cur kitpvp.tmp 1
