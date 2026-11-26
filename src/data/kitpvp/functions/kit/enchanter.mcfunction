# 附魔师（kit = 98）：金套 + 金剑 + 《神学大全》
# 剑的附魔靠"命中玩家"充能，护甲的靠"被玩家打中"充能；书是慢速双充的替代手段
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
item replace entity @s hotbar.2 with minecraft:book{KitBook:1b,Enchantments:[{id:"minecraft:unbreaking",lvl:1s}],display:{Name:'{"text":"《神学大全》","color":"gold","italic":false}',Lore:['{"text":"拿在主手：移速 -30%、身上发光","color":"gray","italic":false}','{"text":"每 15 秒给剑和护甲各 +1 点蓄力","color":"dark_gray","italic":false}']}}

scoreboard players set @s kitpvp.ench_sw 0
scoreboard players set @s kitpvp.ench_ap 0
scoreboard players set @s kitpvp.ench_sword 0
scoreboard players set @s kitpvp.ench_armor 0
scoreboard players set @s kitpvp.ench_book_t 0
scoreboard players set @s kitpvp.ench_book_cd 0
scoreboard players set @s kitpvp.ench_pity 0
scoreboard players set @s kitpvp.ench_hint 0
scoreboard players set @s kitpvp.ench_fx 0
tag @s remove kitpvp.ench_wait
execute as @e[tag=kitpvp.ench_bench] run kill @s
function kitpvp:skill/enchanter/assign_slot
function kitpvp:skill/enchanter/name_refresh

tellraw @s [{"text":"已选择 ","color":"gray"},{"text":"附魔师","color":"light_purple","bold":true}]
tellraw @s [{"text":"打中人 → 剑附魔充能；被打中 → 护甲附魔充能（各 3 点升 1 级）","color":"dark_gray"}]
tellraw @s [{"text":"《神学大全》拿在主手：移速 -30%、发光，每 15 秒给两条各 +1 点","color":"dark_gray"}]
