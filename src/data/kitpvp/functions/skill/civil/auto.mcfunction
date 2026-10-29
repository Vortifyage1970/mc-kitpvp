# 口水补货：上限 3 瓶，每 4 秒（80 刻）补 1 瓶；恶魔形态下补的是恶魔口水
# 数量必须用 clear ... 0 读背包真实值：计数器会因丢瓶子 / 背包满 give 掉地上而虚高（见 04 §八）
scoreboard players set @s kitpvp.tmp 0
execute unless entity @s[tag=kitpvp.civil_demon] store result score @s kitpvp.tmp run clear @s minecraft:splash_potion{KitCivilSpit:1b} 0
execute if entity @s[tag=kitpvp.civil_demon] store result score @s kitpvp.tmp run clear @s minecraft:splash_potion{KitCivilDemonSpit:1b} 0

execute if score @s kitpvp.tmp matches ..2 if entity @s[tag=kitpvp.civil_demon] run function kitpvp:skill/civil/give_demon_spit
execute if score @s kitpvp.tmp matches ..2 unless entity @s[tag=kitpvp.civil_demon] run function kitpvp:skill/civil/give_spit
execute if score @s kitpvp.tmp matches ..2 run scoreboard players set @s kitpvp.cd 80
execute if score @s kitpvp.tmp matches ..2 run title @s actionbar {"text":"补给：+1 口水","color":"green"}
