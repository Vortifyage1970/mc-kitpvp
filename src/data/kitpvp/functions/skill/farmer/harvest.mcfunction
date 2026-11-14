# 种下一颗麦种 → 1~3 个小麦：掷 0..63 再 %3，和 kit/random 同一套 1in2 拼数
scoreboard players operation @s kitpvp.plant_last = @s kitpvp.plant_used
scoreboard players set @s kitpvp.rng 0
execute if predicate kitpvp:random/1in2 run scoreboard players add @s kitpvp.rng 1
execute if predicate kitpvp:random/1in2 run scoreboard players add @s kitpvp.rng 2
execute if predicate kitpvp:random/1in2 run scoreboard players add @s kitpvp.rng 4
execute if predicate kitpvp:random/1in2 run scoreboard players add @s kitpvp.rng 8
execute if predicate kitpvp:random/1in2 run scoreboard players add @s kitpvp.rng 16
execute if predicate kitpvp:random/1in2 run scoreboard players add @s kitpvp.rng 32
scoreboard players operation @s kitpvp.rng %= #farmer_roll kitpvp.game
execute if score @s kitpvp.rng matches 0.. run give @s minecraft:wheat 1
execute if score @s kitpvp.rng matches 1.. run give @s minecraft:wheat 1
execute if score @s kitpvp.rng matches 2.. run give @s minecraft:wheat 1
