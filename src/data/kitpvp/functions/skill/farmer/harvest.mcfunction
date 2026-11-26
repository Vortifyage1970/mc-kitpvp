# 种下一颗麦种 → 50% 得 1 个小麦（0 或 1，2026-11-15 削弱）
scoreboard players operation @s kitpvp.plant_last = @s kitpvp.plant_used
execute if predicate kitpvp:random/1in2 run give @s minecraft:wheat 1
