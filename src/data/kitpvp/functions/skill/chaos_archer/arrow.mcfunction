# 混沌弓箭手：每射一箭后随机装填一支「魔法箭」（17 种，箭本身不带名字）
# 首行推进快照（同表渔夫），漏写会连放
scoreboard players operation @s kitpvp.archer_shot_last = @s kitpvp.archer_shot

# 随机 0..16：1in2 连掷 5 次（0..31）再对 #archer_pool 取模
scoreboard players set #archer_rng kitpvp.game 0
execute if predicate kitpvp:random/1in2 run scoreboard players add #archer_rng kitpvp.game 1
execute if predicate kitpvp:random/1in2 run scoreboard players add #archer_rng kitpvp.game 2
execute if predicate kitpvp:random/1in2 run scoreboard players add #archer_rng kitpvp.game 4
execute if predicate kitpvp:random/1in2 run scoreboard players add #archer_rng kitpvp.game 8
execute if predicate kitpvp:random/1in2 run scoreboard players add #archer_rng kitpvp.game 16
scoreboard players set #archer_pool kitpvp.game 17
scoreboard players operation #archer_rng kitpvp.game %= #archer_pool kitpvp.game

execute if score #archer_rng kitpvp.game matches 0 run give @s minecraft:tipped_arrow{Potion:"minecraft:custom",CustomPotionEffects:[{Id:16b,Amplifier:0b,Duration:200b}]} 1
execute if score #archer_rng kitpvp.game matches 1 run give @s minecraft:tipped_arrow{Potion:"minecraft:custom",CustomPotionEffects:[{Id:25b,Amplifier:0b,Duration:70b}]} 1
execute if score #archer_rng kitpvp.game matches 2 run give @s minecraft:tipped_arrow{Potion:"minecraft:custom",CustomPotionEffects:[{Id:14b,Amplifier:0b,Duration:400b}]} 1
execute if score #archer_rng kitpvp.game matches 3 run give @s minecraft:tipped_arrow{Potion:"minecraft:custom",CustomPotionEffects:[{Id:11b,Amplifier:1b,Duration:200b}]} 1
execute if score #archer_rng kitpvp.game matches 4 run give @s minecraft:tipped_arrow{Potion:"minecraft:custom",CustomPotionEffects:[{Id:8b,Amplifier:1b,Duration:200b}]} 1
execute if score #archer_rng kitpvp.game matches 5 run give @s minecraft:tipped_arrow{Potion:"minecraft:custom",CustomPotionEffects:[{Id:20b,Amplifier:0b,Duration:200b}]} 1
execute if score #archer_rng kitpvp.game matches 6 run give @s minecraft:tipped_arrow{Potion:"minecraft:custom",CustomPotionEffects:[{Id:1b,Amplifier:1b,Duration:400b}]} 1
execute if score #archer_rng kitpvp.game matches 7 run give @s minecraft:tipped_arrow{Potion:"minecraft:custom",CustomPotionEffects:[{Id:9b,Amplifier:0b,Duration:200b}]} 1
execute if score #archer_rng kitpvp.game matches 8 run give @s minecraft:tipped_arrow{Potion:"minecraft:custom",CustomPotionEffects:[{Id:2b,Amplifier:0b,Duration:200b}]} 1
execute if score #archer_rng kitpvp.game matches 9 run give @s minecraft:spectral_arrow 1
execute if score #archer_rng kitpvp.game matches 10 run give @s minecraft:tipped_arrow{Potion:"minecraft:custom",CustomPotionEffects:[{Id:18b,Amplifier:0b,Duration:200b}]} 1
execute if score #archer_rng kitpvp.game matches 11 run give @s minecraft:tipped_arrow{Potion:"minecraft:custom",CustomPotionEffects:[{Id:6b,Amplifier:1b}]} 1
execute if score #archer_rng kitpvp.game matches 12 run give @s minecraft:tipped_arrow{Potion:"minecraft:custom",CustomPotionEffects:[{Id:7b,Amplifier:1b}]} 1
execute if score #archer_rng kitpvp.game matches 13 run give @s minecraft:tipped_arrow{Potion:"minecraft:custom",CustomPotionEffects:[{Id:5b,Amplifier:0b,Duration:450b}]} 1
execute if score #archer_rng kitpvp.game matches 14 run give @s minecraft:tipped_arrow{Potion:"minecraft:custom",CustomPotionEffects:[{Id:19b,Amplifier:0b,Duration:200b}]} 1
execute if score #archer_rng kitpvp.game matches 15 run give @s minecraft:tipped_arrow{Potion:"minecraft:custom",CustomPotionEffects:[{Id:10b,Amplifier:1b,Duration:200b}]} 1
execute if score #archer_rng kitpvp.game matches 16 run give @s minecraft:tipped_arrow{Potion:"minecraft:custom",CustomPotionEffects:[{Id:28b,Amplifier:0b,Duration:200b}]} 1
