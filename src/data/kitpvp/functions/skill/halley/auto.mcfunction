# 补货：上限 4 枚，每 50 秒（1000 刻）补 1 枚；数量用 clear ... 0 读背包真实值（同 skill/earth/auto）
scoreboard players set @s kitpvp.tmp 0
execute store result score @s kitpvp.tmp run clear @s minecraft:magma_cube_spawn_egg{KitHalleyEgg:1b} 0
execute if score @s kitpvp.tmp matches ..3 run function kitpvp:skill/halley/give_egg
execute if score @s kitpvp.tmp matches ..3 run scoreboard players set @s kitpvp.halley_cd 1000
execute if score @s kitpvp.tmp matches 1 run title @s actionbar {"text":"补给：天堂制造","color":"gold"}
