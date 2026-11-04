# 出生点 7/7 = (-33,61,-4957)：D
tp @s -33 61 -4957
spawnpoint @s -33 61 -4957
scoreboard players set @s kitpvp.spawn_slot 7
execute at @s run summon minecraft:marker ~ ~ ~ {Tags:["kitpvp.spawn_anchor","kitpvp.spawn_anchor.7"]}
tag @s add kitpvp.spawn_assigned
scoreboard players add #cur kitpvp.tmp 1
execute if score #cur kitpvp.tmp matches 8.. run scoreboard players set #cur kitpvp.tmp 1
