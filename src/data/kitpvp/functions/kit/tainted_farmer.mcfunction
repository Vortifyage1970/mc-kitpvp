# 里·农夫（kit = 34）：原版铁铲 + 皮革/铁混甲；靠"起义"把田野变成战场
# 铁锄与表农夫同一把 used 统计（farm_used），所以耕地被动两家共享（见 kitpvp:skill/farmer/*）
function kitpvp:util/clear_player

scoreboard players set @s kitpvp.kit 34
tag @s add kitpvp.selected
scoreboard players set @s kitpvp.alive 1
scoreboard players set @s kitpvp.lives 3

item replace entity @s armor.head with minecraft:leather_helmet{Unbreakable:1b,Enchantments:[{id:"minecraft:unbreaking",lvl:3}],Trim:{material:"minecraft:redstone",pattern:"minecraft:rib"}}
item replace entity @s armor.chest with minecraft:iron_chestplate{Unbreakable:1b,Enchantments:[{id:"minecraft:unbreaking",lvl:3}],Trim:{material:"minecraft:redstone",pattern:"minecraft:rib"}}
item replace entity @s armor.legs with minecraft:leather_leggings{Unbreakable:1b,Enchantments:[{id:"minecraft:unbreaking",lvl:3}],Trim:{material:"minecraft:redstone",pattern:"minecraft:rib"}}
item replace entity @s armor.feet with minecraft:iron_boots{Unbreakable:1b,Enchantments:[{id:"minecraft:unbreaking",lvl:3}],Trim:{material:"minecraft:redstone",pattern:"minecraft:rib"}}

item replace entity @s hotbar.0 with minecraft:iron_shovel{KitTaintedFarmerShovel:1b,Unbreakable:1b,Enchantments:[{id:"minecraft:sharpness",lvl:1}]}
item replace entity @s hotbar.1 with minecraft:iron_hoe{KitTaintedFarmerHoe:1b,Unbreakable:1b,Enchantments:[{id:"minecraft:knockback",lvl:2}]}
item replace entity @s hotbar.2 with minecraft:crafting_table 2
item replace entity @s hotbar.3 with minecraft:baked_potato 12

# 两种蛋都借用原版蛋（display.Name 会成为召唤物的 CustomName，dispatch 就靠这个名字分流）
# 起义蛋一次性；召集蛋上限 1、冷却 45 秒，冷却走完由 skill/tainted_farmer/rally_refill 补回
give @s minecraft:mooshroom_spawn_egg{KitTaintedRise:1b,display:{Name:'{"text":"开始一场起义","color":"gold","italic":false}'}} 1
give @s minecraft:husk_spawn_egg{KitTaintedRally:1b,display:{Name:'{"text":"召集农民","color":"yellow","italic":false}'}} 1

function kitpvp:skill/tainted_farmer/team_slot

tellraw @s [{"text":"已选择 ","color":"gray"},{"text":"里·农夫","color":"dark_green","bold":true}]
playsound minecraft:ui.button.click master @s ~ ~ ~ 1 1.2
