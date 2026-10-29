# 冷度 0..100 = 0..5 秒：满 1 秒起给缓慢 I，每多 1 秒升一级，最高 V
execute if score @s kitpvp.coldness matches 20..39 run effect give @s minecraft:slowness 1 0 true
execute if score @s kitpvp.coldness matches 40..59 run effect give @s minecraft:slowness 1 1 true
execute if score @s kitpvp.coldness matches 60..79 run effect give @s minecraft:slowness 1 2 true
execute if score @s kitpvp.coldness matches 80..99 run effect give @s minecraft:slowness 1 3 true
execute if score @s kitpvp.coldness matches 100.. run effect give @s minecraft:slowness 1 4 true
