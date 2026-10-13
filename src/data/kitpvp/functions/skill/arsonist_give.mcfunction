# 补发 1 瓶并重置冷却（set cd 900 在最后一行：补货成功才罚冷却）
give @s minecraft:splash_potion{KitFireBomb:1b,CustomPotionColor:16750848,display:{Name:'{"text":"燃烧瓶","color":"gold","bold":true}'}} 1
scoreboard players add @s kitpvp.arsonist_ammo 1
scoreboard players set @s kitpvp.cd 900

title @s actionbar {"text":"补给：+1 燃烧瓶","color":"gold"}
playsound minecraft:entity.arrow.hit_player master @s ~ ~ ~ 0.7 1.4
