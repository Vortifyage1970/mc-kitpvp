# 战士（kit = 1）：先清场再写回 kit，顺序不可调
function kitpvp:util/clear_player
scoreboard players set @s kitpvp.kit 1
tag @s add kitpvp.selected

scoreboard players set @s kitpvp.alive 1
scoreboard players set @s kitpvp.lives 3

attribute @s minecraft:generic.max_health base set 20
attribute @s minecraft:generic.movement_speed base set 0.1

item replace entity @s armor.head with minecraft:iron_helmet{Unbreakable:1b}
item replace entity @s armor.chest with minecraft:iron_chestplate{Unbreakable:1b}
item replace entity @s armor.legs with minecraft:iron_leggings{Unbreakable:1b}
item replace entity @s armor.feet with minecraft:iron_boots{Unbreakable:1b}
item replace entity @s hotbar.0 with minecraft:iron_sword{Unbreakable:1b}
item replace entity @s hotbar.1 with minecraft:cooked_beef 24
give @s minecraft:golden_apple 2
tellraw @s [{"text":"已选择 ","color":"gray"},{"text":"战士","color":"red","bold":true}]
