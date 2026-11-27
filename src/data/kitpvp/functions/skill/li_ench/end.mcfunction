tellraw @a [{"text":"◆　","color":"light_purple"},{"text":"坐杀博徒 · 收束","color":"gray","bold":true},{"text":"　◆","color":"light_purple"}]
execute as @a at @s run playsound minecraft:block.beacon.deactivate master @s ~ ~ ~ 0.6 1.2
tag @s remove kitpvp.ench_domain
scoreboard players set @s kitpvp.ench_domain_t 0
effect clear @s minecraft:speed
effect clear @s minecraft:haste
effect clear @s minecraft:regeneration

