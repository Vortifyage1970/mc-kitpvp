tag @s remove kitpvp.civil_demon
scoreboard players set @s kitpvp.civil_demon_timer 0

# 恶魔口水换回普通口水（按当前瓶数换）
scoreboard players set @s kitpvp.tmp 0
execute store result score @s kitpvp.tmp run clear @s minecraft:splash_potion{KitCivilDemonSpit:1b} 0
execute if score @s kitpvp.tmp matches 1.. run function kitpvp:skill/civil/give_spit
execute if score @s kitpvp.tmp matches 2.. run function kitpvp:skill/civil/give_spit
execute if score @s kitpvp.tmp matches 3.. run function kitpvp:skill/civil/give_spit

# 武器换回木棍与红砖；锁链护腿不恢复（永久失去）
clear @s minecraft:blaze_rod{KitCivilRod:1b}
clear @s minecraft:brick{KitCivilDemonBrick:1b}
give @s minecraft:stick{KitCivilStick:1b,Enchantments:[{id:"minecraft:sharpness",lvl:5}]}
give @s minecraft:brick{KitCivilBrick:1b,Enchantments:[{id:"minecraft:knockback",lvl:2}]}

title @s actionbar {"text":"恶魔形态结束","color":"gray"}
playsound minecraft:entity.blaze.death master @s ~ ~ ~ 0.8 1.2
