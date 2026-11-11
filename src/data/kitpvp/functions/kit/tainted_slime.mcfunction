# 里·史莱姆（kit = 31）：经典（里）——与史莱姆同装，全件加耐久 III；蓄力火箭跳
function kitpvp:util/clear_player

scoreboard players set @s kitpvp.kit 31
tag @s add kitpvp.selected
scoreboard players set @s kitpvp.alive 1

item replace entity @s armor.head with minecraft:iron_helmet{Unbreakable:1b,Enchantments:[{id:"minecraft:unbreaking",lvl:3}]}
item replace entity @s armor.chest with minecraft:leather_chestplate{display:{color:10079282},Unbreakable:1b,Enchantments:[{id:"minecraft:unbreaking",lvl:3}]}
item replace entity @s armor.legs with minecraft:iron_leggings{Unbreakable:1b,Enchantments:[{id:"minecraft:unbreaking",lvl:3}]}
item replace entity @s armor.feet with minecraft:diamond_boots{Unbreakable:1b,Enchantments:[{id:"minecraft:feather_falling",lvl:3},{id:"minecraft:unbreaking",lvl:3}]}
item replace entity @s hotbar.0 with minecraft:stone_sword{Unbreakable:1b,Enchantments:[{id:"minecraft:unbreaking",lvl:3}]}
item replace entity @s hotbar.1 with minecraft:cooked_beef 15

function kitpvp:skill/tainted_slime/passive

scoreboard players set @s kitpvp.lives 3

tellraw @s [{"text":"已选择 ","color":"gray"},{"text":"里·史莱姆","color":"dark_red","bold":true}]
playsound minecraft:ui.button.click master @s ~ ~ ~ 1 1.2
