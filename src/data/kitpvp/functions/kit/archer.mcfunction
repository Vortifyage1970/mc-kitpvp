# 弓箭手（kit = 2）；副手弓的 KitBow:1b 是换弹技能的识别标记，不要摘
function kitpvp:util/clear_player
scoreboard players set @s kitpvp.kit 2
scoreboard players set @s kitpvp.lives 3

item replace entity @s armor.head with minecraft:leather_helmet{Unbreakable:1b} 1
item replace entity @s armor.chest with minecraft:leather_chestplate{Unbreakable:1b} 1
item replace entity @s armor.legs with minecraft:iron_leggings{Unbreakable:1b} 1
item replace entity @s armor.feet with minecraft:iron_boots{Unbreakable:1b} 1

item replace entity @s weapon.mainhand with minecraft:stone_sword{Unbreakable:1b} 1
item replace entity @s weapon.offhand with minecraft:bow{KitBow:1b,Unbreakable:1b} 1

give @s minecraft:cooked_beef 24
give @s minecraft:arrow 12

tag @s add kitpvp.selected

tellraw @s [{"text":"已选择：","color":"gray"},{"text":"弓箭手","color":"aqua","bold":true}]
