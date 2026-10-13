# 以落点为中心铺 4x4 火：仅当该格是空气且下方有支撑（绝不覆盖原有方块）
execute positioned ~-2 ~ ~-2 if block ~ ~ ~ air unless block ~ ~-1 ~ air run function kitpvp:skill/arsonist_place_one
execute positioned ~-2 ~ ~-1 if block ~ ~ ~ air unless block ~ ~-1 ~ air run function kitpvp:skill/arsonist_place_one
execute positioned ~-2 ~ ~0 if block ~ ~ ~ air unless block ~ ~-1 ~ air run function kitpvp:skill/arsonist_place_one
execute positioned ~-2 ~ ~1 if block ~ ~ ~ air unless block ~ ~-1 ~ air run function kitpvp:skill/arsonist_place_one
execute positioned ~-1 ~ ~-2 if block ~ ~ ~ air unless block ~ ~-1 ~ air run function kitpvp:skill/arsonist_place_one
execute positioned ~-1 ~ ~-1 if block ~ ~ ~ air unless block ~ ~-1 ~ air run function kitpvp:skill/arsonist_place_one
execute positioned ~-1 ~ ~0 if block ~ ~ ~ air unless block ~ ~-1 ~ air run function kitpvp:skill/arsonist_place_one
execute positioned ~-1 ~ ~1 if block ~ ~ ~ air unless block ~ ~-1 ~ air run function kitpvp:skill/arsonist_place_one
execute positioned ~0 ~ ~-2 if block ~ ~ ~ air unless block ~ ~-1 ~ air run function kitpvp:skill/arsonist_place_one
execute positioned ~0 ~ ~-1 if block ~ ~ ~ air unless block ~ ~-1 ~ air run function kitpvp:skill/arsonist_place_one
execute positioned ~0 ~ ~0 if block ~ ~ ~ air unless block ~ ~-1 ~ air run function kitpvp:skill/arsonist_place_one
execute positioned ~0 ~ ~1 if block ~ ~ ~ air unless block ~ ~-1 ~ air run function kitpvp:skill/arsonist_place_one
execute positioned ~1 ~ ~-2 if block ~ ~ ~ air unless block ~ ~-1 ~ air run function kitpvp:skill/arsonist_place_one
execute positioned ~1 ~ ~-1 if block ~ ~ ~ air unless block ~ ~-1 ~ air run function kitpvp:skill/arsonist_place_one
execute positioned ~1 ~ ~0 if block ~ ~ ~ air unless block ~ ~-1 ~ air run function kitpvp:skill/arsonist_place_one
execute positioned ~1 ~ ~1 if block ~ ~ ~ air unless block ~ ~-1 ~ air run function kitpvp:skill/arsonist_place_one

# 给本批新 marker 装 100 刻寿命（arsonist_new 标记"本批"，避免误伤上一批）
execute as @e[type=minecraft:marker,tag=kitpvp.arsonist_new] run scoreboard players set @s kitpvp.fire_timer 100
execute as @e[type=minecraft:marker,tag=kitpvp.arsonist_new] run tag @s remove kitpvp.arsonist_new
