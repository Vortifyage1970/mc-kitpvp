# 读书的音效循环：150 刻一轮（附魔台 → 村民 → 猫 → 悦灵），每刻冒一点附魔粒子
scoreboard players add @s kitpvp.ench_fx 1
execute if score @s kitpvp.ench_fx matches 151.. run scoreboard players set @s kitpvp.ench_fx 0
execute if score @s kitpvp.ench_fx matches 20 run playsound minecraft:block.enchantment_table.use master @s ~ ~ ~ 0.3 1.25
execute if score @s kitpvp.ench_fx matches 60 run playsound minecraft:entity.villager.ambient master @s ~ ~ ~ 0.35 1.45
execute if score @s kitpvp.ench_fx matches 100 run playsound minecraft:entity.cat.purr master @s ~ ~ ~ 0.45 1.2
execute if score @s kitpvp.ench_fx matches 140 run playsound minecraft:entity.allay.ambient_with_item master @s ~ ~ ~ 0.4 1.5
particle minecraft:enchant ~ ~1 ~ 0.6 0.9 0.6 0.02 2
execute if score @s kitpvp.ench_fx matches 75 run particle minecraft:end_rod ~ ~1 ~ 0.5 0.8 0.5 0.02 6
