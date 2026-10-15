# 里·战士（kit = 23）：经典（里）——金甲 + 狂战士药水的黑暗版战士
function kitpvp:util/clear_player

scoreboard players set @s kitpvp.kit 23
tag @s add kitpvp.selected

scoreboard players set @s kitpvp.alive 1
scoreboard players set @s kitpvp.lives 3

item replace entity @s armor.head with minecraft:golden_helmet{Unbreakable:1b,Enchantments:[{id:"minecraft:unbreaking",lvl:3}]}
item replace entity @s armor.chest with minecraft:iron_chestplate{Unbreakable:1b,Enchantments:[{id:"minecraft:unbreaking",lvl:3}]}
item replace entity @s armor.legs with minecraft:golden_leggings{Unbreakable:1b,Enchantments:[{id:"minecraft:unbreaking",lvl:3}]}
item replace entity @s armor.feet with minecraft:golden_boots{Unbreakable:1b,Enchantments:[{id:"minecraft:unbreaking",lvl:3}]}
item replace entity @s hotbar.0 with minecraft:golden_sword{Unbreakable:1b,Enchantments:[{id:"minecraft:sharpness",lvl:3}]}
item replace entity @s hotbar.1 with minecraft:cooked_beef 12

give @s minecraft:potion{CustomPotionColor:9643043,CustomPotionEffects:[{Id:5b,Amplifier:1b,Duration:300}],display:{Name:'{"text":"狂战士药水","color":"red","bold":true}'}} 3

playsound minecraft:ui.button.click master @s ~ ~ ~ 1 1.2
