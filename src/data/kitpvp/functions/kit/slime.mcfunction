# 史莱姆（kit = 10）
function kitpvp:util/clear_player

scoreboard players set @s kitpvp.kit 10
tag @s add kitpvp.selected
scoreboard players set @s kitpvp.alive 1

item replace entity @s armor.head with minecraft:iron_helmet{Unbreakable:1b}
item replace entity @s armor.chest with minecraft:leather_chestplate{display:{color:10079282},Unbreakable:1b}
item replace entity @s armor.legs with minecraft:iron_leggings{Unbreakable:1b}
item replace entity @s armor.feet with minecraft:diamond_boots{Enchantments:[{id:"minecraft:feather_falling",lvl:3}],Unbreakable:1b}
item replace entity @s hotbar.0 with minecraft:stone_sword{Unbreakable:1b}
item replace entity @s hotbar.1 with minecraft:cooked_beef 24

function kitpvp:skill/slime/passive

scoreboard players set @s kitpvp.lives 3

tellraw @s [{"text":"[职业] ","color":"green","bold":true},{"text":"已选择 ","color":"gray"},{"text":"史莱姆","color":"yellow","bold":true}]
playsound minecraft:entity.slime.jump master @s ~ ~ ~ 0.8 1.0
