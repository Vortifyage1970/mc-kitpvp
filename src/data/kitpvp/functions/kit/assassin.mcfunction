# 刺客（kit = 4）：黑色皮革 + 锋利 I 钻石剑；护甲 7 由皮革自然提供，不额外 set attribute
function kitpvp:util/clear_player

scoreboard players set @s kitpvp.kit 4
tag @s add kitpvp.selected
scoreboard players set @s kitpvp.alive 1

item replace entity @s armor.head with minecraft:leather_helmet{display:{color:1908001},Unbreakable:1b}
item replace entity @s armor.chest with minecraft:leather_chestplate{display:{color:1908001},Unbreakable:1b}
item replace entity @s armor.legs with minecraft:leather_leggings{display:{color:1908001},Unbreakable:1b}
item replace entity @s armor.feet with minecraft:leather_boots{display:{color:1908001},Unbreakable:1b}
item replace entity @s hotbar.0 with minecraft:diamond_sword{Enchantments:[{id:"minecraft:sharpness",lvl:1}],Unbreakable:1b}
item replace entity @s hotbar.1 with minecraft:cooked_beef 24

function kitpvp:skill/assassin/passive

scoreboard players set @s kitpvp.lives 3

function kitpvp:skill/assassin/give_item

tellraw @s [{"text":"已选择 ","color":"gray"},{"text":"刺客","color":"dark_purple","bold":true}]
playsound minecraft:ui.button.click master @s ~ ~ ~ 1 1.2
