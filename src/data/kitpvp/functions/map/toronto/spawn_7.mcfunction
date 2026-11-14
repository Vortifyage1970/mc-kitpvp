tp @s 5992 64 6001
spawnpoint @s 5992 64 6001
scoreboard players set @s kitpvp.spawn_slot 7
execute at @s run summon minecraft:marker ~ ~ ~ {Tags:["kitpvp.spawn_anchor","kitpvp.spawn_anchor.7"]}
tag @s add kitpvp.spawn_assigned
scoreboard players add #cur kitpvp.tmp 1
execute if score #cur kitpvp.tmp matches 10.. run scoreboard players set #cur kitpvp.tmp 1
