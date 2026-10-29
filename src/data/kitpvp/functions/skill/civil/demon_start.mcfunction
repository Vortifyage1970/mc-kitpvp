# 恶魔形态：冷却 180 秒（3600 刻），持续 60 秒（1200 刻）
tag @s add kitpvp.civil_demon
scoreboard players set @s kitpvp.civil_demon_timer 1200
scoreboard players set @s kitpvp.cd2 3600

# 口水整套换成恶魔口水（按当前瓶数换，最多 3 瓶）
scoreboard players set @s kitpvp.tmp 0
execute store result score @s kitpvp.tmp run clear @s minecraft:splash_potion{KitCivilSpit:1b} 0
execute if score @s kitpvp.tmp matches 1.. run function kitpvp:skill/civil/give_demon_spit
execute if score @s kitpvp.tmp matches 2.. run function kitpvp:skill/civil/give_demon_spit
execute if score @s kitpvp.tmp matches 3.. run function kitpvp:skill/civil/give_demon_spit

# 主武器换烈焰棒，板砖换恶魔板砖；锁链护腿从此永久消失（技能结束后也不回来）
clear @s minecraft:stick{KitCivilStick:1b}
clear @s minecraft:brick{KitCivilBrick:1b}
give @s minecraft:blaze_rod{KitCivilRod:1b,Enchantments:[{id:"minecraft:sharpness",lvl:5},{id:"minecraft:fire_aspect",lvl:1}]}
give @s minecraft:brick{KitCivilDemonBrick:1b,Enchantments:[{id:"minecraft:knockback",lvl:3}]}
item replace entity @s armor.legs with minecraft:air

title @s title {"text":"恶魔形态","color":"dark_red","bold":true}
title @s subtitle {"text":"60 秒","color":"dark_gray"}
playsound minecraft:entity.blaze.ambient master @s ~ ~ ~ 1.2 0.6
