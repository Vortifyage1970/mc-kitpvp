# 附魔师（kit = 34）：金套 + 金剑，每 46.5 秒给剑和护甲各 +1 级附魔
function kitpvp:util/clear_player
scoreboard players set @s kitpvp.kit 98
tag @s add kitpvp.selected

scoreboard players set @s kitpvp.alive 1
scoreboard players set @s kitpvp.lives 3

attribute @s minecraft:generic.max_health base set 20
attribute @s minecraft:generic.movement_speed base set 0.1

item replace entity @s armor.head with minecraft:golden_helmet{Unbreakable:1b,KitEnch:1b}
item replace entity @s armor.chest with minecraft:golden_chestplate{Unbreakable:1b,KitEnch:1b}
item replace entity @s armor.legs with minecraft:golden_leggings{Unbreakable:1b,KitEnch:1b}
item replace entity @s armor.feet with minecraft:golden_boots{Unbreakable:1b,KitEnch:1b}
item replace entity @s hotbar.0 with minecraft:golden_sword{Unbreakable:1b,KitEnch:1b}
item replace entity @s hotbar.1 with minecraft:cooked_beef 24

scoreboard players set @s kitpvp.ench_roll 0
scoreboard players set @s kitpvp.ench_timer 300
scoreboard players set @s kitpvp.ench_period 300
scoreboard players set @s kitpvp.ench_fill -1
scoreboard players set @s kitpvp.ench_pity 0
execute as @e[tag=kitpvp.ench_bench] run kill @s
function kitpvp:skill/enchanter/assign_slot
function kitpvp:skill/enchanter/name_refresh

tellraw @s [{"text":"已选择 ","color":"gray"},{"text":"附魔师","color":"light_purple","bold":true}]
tellraw @s [{"text":"每 46.5 秒剑和护甲各 +1 级附魔，15 秒后开始，8 分钟封顶","color":"dark_gray"}]
