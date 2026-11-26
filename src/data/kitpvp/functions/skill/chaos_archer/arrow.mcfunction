# 混沌弓箭手：每射一箭后随机装填一支魔法箭（17 种）
# ⚠ Duration 必须写整数（Duration:200），写 200b 会当成字节溢出成 -56 → 效果直接消失
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

execute if score #archer_rng kitpvp.game matches 0 run give @s minecraft:tipped_arrow{Potion:"minecraft:custom",CustomPotionEffects:[{Id:16,Amplifier:0,Duration:200}],display:{Name:'{"text":"夜视箭","color":"light_purple","italic":false}'}} 1
execute if score #archer_rng kitpvp.game matches 1 run give @s minecraft:tipped_arrow{Potion:"minecraft:custom",CustomPotionEffects:[{Id:25,Amplifier:0,Duration:70}],display:{Name:'{"text":"漂浮箭","color":"light_purple","italic":false}'}} 1
execute if score #archer_rng kitpvp.game matches 2 run give @s minecraft:tipped_arrow{Potion:"minecraft:custom",CustomPotionEffects:[{Id:14,Amplifier:0,Duration:400}],display:{Name:'{"text":"隐身箭","color":"light_purple","italic":false}'}} 1
execute if score #archer_rng kitpvp.game matches 3 run give @s minecraft:tipped_arrow{Potion:"minecraft:custom",CustomPotionEffects:[{Id:11,Amplifier:1,Duration:200}],display:{Name:'{"text":"抗性箭","color":"light_purple","italic":false}'}} 1
execute if score #archer_rng kitpvp.game matches 4 run give @s minecraft:tipped_arrow{Potion:"minecraft:custom",CustomPotionEffects:[{Id:8,Amplifier:1,Duration:200}],display:{Name:'{"text":"跳跃箭","color":"light_purple","italic":false}'}} 1
execute if score #archer_rng kitpvp.game matches 5 run give @s minecraft:tipped_arrow{Potion:"minecraft:custom",CustomPotionEffects:[{Id:20,Amplifier:0,Duration:200}],display:{Name:'{"text":"凋零箭","color":"light_purple","italic":false}'}} 1
execute if score #archer_rng kitpvp.game matches 6 run give @s minecraft:tipped_arrow{Potion:"minecraft:custom",CustomPotionEffects:[{Id:1,Amplifier:1,Duration:400}],display:{Name:'{"text":"速度箭","color":"light_purple","italic":false}'}} 1
execute if score #archer_rng kitpvp.game matches 7 run give @s minecraft:tipped_arrow{Potion:"minecraft:custom",CustomPotionEffects:[{Id:9,Amplifier:0,Duration:200}],display:{Name:'{"text":"反胃箭","color":"light_purple","italic":false}'}} 1
execute if score #archer_rng kitpvp.game matches 8 run give @s minecraft:tipped_arrow{Potion:"minecraft:custom",CustomPotionEffects:[{Id:2,Amplifier:0,Duration:200}],display:{Name:'{"text":"缓慢箭","color":"light_purple","italic":false}'}} 1
execute if score #archer_rng kitpvp.game matches 9 run give @s minecraft:spectral_arrow{display:{Name:'{"text":"光灵箭","color":"light_purple","italic":false}'}} 1
execute if score #archer_rng kitpvp.game matches 10 run give @s minecraft:tipped_arrow{Potion:"minecraft:custom",CustomPotionEffects:[{Id:18,Amplifier:0,Duration:200}],display:{Name:'{"text":"虚弱箭","color":"light_purple","italic":false}'}} 1
execute if score #archer_rng kitpvp.game matches 11 run give @s minecraft:tipped_arrow{Potion:"minecraft:custom",CustomPotionEffects:[{Id:6,Amplifier:1}],display:{Name:'{"text":"治疗箭","color":"light_purple","italic":false}'}} 1
execute if score #archer_rng kitpvp.game matches 12 run give @s minecraft:tipped_arrow{Potion:"minecraft:custom",CustomPotionEffects:[{Id:7,Amplifier:1}],display:{Name:'{"text":"伤害箭","color":"light_purple","italic":false}'}} 1
execute if score #archer_rng kitpvp.game matches 13 run give @s minecraft:tipped_arrow{Potion:"minecraft:custom",CustomPotionEffects:[{Id:5,Amplifier:0,Duration:450}],display:{Name:'{"text":"力量箭","color":"light_purple","italic":false}'}} 1
execute if score #archer_rng kitpvp.game matches 14 run give @s minecraft:tipped_arrow{Potion:"minecraft:custom",CustomPotionEffects:[{Id:19,Amplifier:0,Duration:200}],display:{Name:'{"text":"中毒箭","color":"light_purple","italic":false}'}} 1
execute if score #archer_rng kitpvp.game matches 15 run give @s minecraft:tipped_arrow{Potion:"minecraft:custom",CustomPotionEffects:[{Id:10,Amplifier:1,Duration:200}],display:{Name:'{"text":"恢复箭","color":"light_purple","italic":false}'}} 1
execute if score #archer_rng kitpvp.game matches 16 run give @s minecraft:tipped_arrow{Potion:"minecraft:custom",CustomPotionEffects:[{Id:28,Amplifier:0,Duration:200}],display:{Name:'{"text":"缓降箭","color":"light_purple","italic":false}'}} 1
