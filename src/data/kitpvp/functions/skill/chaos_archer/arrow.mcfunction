# 天堂制造……不，混沌弓箭手：每射一箭后随机装填一支「魔法箭」
# 首行推进快照（同表渔夫）
scoreboard players operation @s kitpvp.archer_shot_last = @s kitpvp.archer_shot

# 随机 0..15：1in2 连掷 4 次
scoreboard players set #archer_rng kitpvp.game 0
execute if predicate kitpvp:random/1in2 run scoreboard players add #archer_rng kitpvp.game 1
execute if predicate kitpvp:random/1in2 run scoreboard players add #archer_rng kitpvp.game 2
execute if predicate kitpvp:random/1in2 run scoreboard players add #archer_rng kitpvp.game 4
execute if predicate kitpvp:random/1in2 run scoreboard players add #archer_rng kitpvp.game 8

execute if score #archer_rng kitpvp.game matches 0 run give @s minecraft:tipped_arrow{Potion:"minecraft:custom",CustomPotionEffects:[{Id:16b,Amplifier:0b,Duration:200b}],display:{Name:'{"text":"魔法箭·夜视","color":"light_purple","italic":false}'}} 1
execute if score #archer_rng kitpvp.game matches 1 run give @s minecraft:tipped_arrow{Potion:"minecraft:custom",CustomPotionEffects:[{Id:25b,Amplifier:0b,Duration:70b}],display:{Name:'{"text":"魔法箭·漂浮","color":"light_purple","italic":false}'}} 1
execute if score #archer_rng kitpvp.game matches 2 run give @s minecraft:tipped_arrow{Potion:"minecraft:custom",CustomPotionEffects:[{Id:14b,Amplifier:0b,Duration:400b}],display:{Name:'{"text":"魔法箭·隐身","color":"light_purple","italic":false}'}} 1
execute if score #archer_rng kitpvp.game matches 3 run give @s minecraft:tipped_arrow{Potion:"minecraft:custom",CustomPotionEffects:[{Id:11b,Amplifier:1b,Duration:200b}],display:{Name:'{"text":"魔法箭·抗性提升","color":"light_purple","italic":false}'}} 1
execute if score #archer_rng kitpvp.game matches 4 run give @s minecraft:tipped_arrow{Potion:"minecraft:custom",CustomPotionEffects:[{Id:8b,Amplifier:1b,Duration:200b}],display:{Name:'{"text":"魔法箭·跳跃提升","color":"light_purple","italic":false}'}} 1
execute if score #archer_rng kitpvp.game matches 5 run give @s minecraft:tipped_arrow{Potion:"minecraft:custom",CustomPotionEffects:[{Id:20b,Amplifier:0b,Duration:200b}],display:{Name:'{"text":"魔法箭·凋零","color":"light_purple","italic":false}'}} 1
execute if score #archer_rng kitpvp.game matches 6 run give @s minecraft:tipped_arrow{Potion:"minecraft:custom",CustomPotionEffects:[{Id:1b,Amplifier:1b,Duration:400b}],display:{Name:'{"text":"魔法箭·速度","color":"light_purple","italic":false}'}} 1
execute if score #archer_rng kitpvp.game matches 7 run give @s minecraft:tipped_arrow{Potion:"minecraft:custom",CustomPotionEffects:[{Id:9b,Amplifier:0b,Duration:200b}],display:{Name:'{"text":"魔法箭·反胃","color":"light_purple","italic":false}'}} 1
execute if score #archer_rng kitpvp.game matches 8 run give @s minecraft:tipped_arrow{Potion:"minecraft:custom",CustomPotionEffects:[{Id:2b,Amplifier:0b,Duration:200b}],display:{Name:'{"text":"魔法箭·缓慢","color":"light_purple","italic":false}'}} 1
execute if score #archer_rng kitpvp.game matches 9 run give @s minecraft:spectral_arrow{display:{Name:'{"text":"魔法箭·光灵","color":"yellow","italic":false}'}} 1
execute if score #archer_rng kitpvp.game matches 10 run give @s minecraft:tipped_arrow{Potion:"minecraft:custom",CustomPotionEffects:[{Id:18b,Amplifier:0b,Duration:200b}],display:{Name:'{"text":"魔法箭·虚弱","color":"light_purple","italic":false}'}} 1
execute if score #archer_rng kitpvp.game matches 11 run give @s minecraft:tipped_arrow{Potion:"minecraft:custom",CustomPotionEffects:[{Id:6b,Amplifier:1b}],display:{Name:'{"text":"魔法箭·瞬间治疗","color":"light_purple","italic":false}'}} 1
execute if score #archer_rng kitpvp.game matches 12 run give @s minecraft:tipped_arrow{Potion:"minecraft:custom",CustomPotionEffects:[{Id:7b,Amplifier:1b}],display:{Name:'{"text":"魔法箭·瞬间伤害","color":"light_purple","italic":false}'}} 1
execute if score #archer_rng kitpvp.game matches 13 run give @s minecraft:tipped_arrow{Potion:"minecraft:custom",CustomPotionEffects:[{Id:5b,Amplifier:0b,Duration:450b}],display:{Name:'{"text":"魔法箭·力量","color":"light_purple","italic":false}'}} 1
execute if score #archer_rng kitpvp.game matches 14 run give @s minecraft:tipped_arrow{Potion:"minecraft:custom",CustomPotionEffects:[{Id:19b,Amplifier:0b,Duration:200b}],display:{Name:'{"text":"魔法箭·中毒","color":"light_purple","italic":false}'}} 1
execute if score #archer_rng kitpvp.game matches 15 run give @s minecraft:tipped_arrow{Potion:"minecraft:custom",CustomPotionEffects:[{Id:10b,Amplifier:1b,Duration:200b}],display:{Name:'{"text":"魔法箭·生命恢复","color":"light_purple","italic":false}'}} 1
