tp @s -1200 64 -686
spawnpoint @s -1200 64 -686
tag @s add kitpvp.spawn_assigned
scoreboard players add #cur kitpvp.tmp 1
execute if score #cur kitpvp.tmp matches 7.. run scoreboard players set #cur kitpvp.tmp 1
