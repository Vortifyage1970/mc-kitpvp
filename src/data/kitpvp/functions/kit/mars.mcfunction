# 火星（kit = 70）：金甲 + 诅咒剑（实际伤害 2）+ 熟鸡肉 + 一次性「地鸣」
function kitpvp:util/clear_player

scoreboard players set @s kitpvp.kit 70
tag @s add kitpvp.selected
scoreboard players set @s kitpvp.alive 1
scoreboard players set @s kitpvp.lives 3

# 皮革染 12326679，金甲保持金色（1.20.1 金甲不可染色，和 1.12.2 一致）
item replace entity @s armor.head with minecraft:leather_helmet{Unbreakable:1b,display:{color:12326679},Enchantments:[{id:"minecraft:protection",lvl:3}]}
item replace entity @s armor.chest with minecraft:golden_chestplate{Unbreakable:1b,Enchantments:[{id:"minecraft:protection",lvl:1}]}
item replace entity @s armor.legs with minecraft:golden_leggings{Unbreakable:1b,Enchantments:[{id:"minecraft:protection",lvl:1}]}
item replace entity @s armor.feet with minecraft:leather_boots{Unbreakable:1b,display:{color:12326679},Enchantments:[{id:"minecraft:protection",lvl:3}]}

item replace entity @s weapon.mainhand with minecraft:golden_sword{KitMarsSword:1b,Unbreakable:1b,Enchantments:[{id:"minecraft:unbreaking",lvl:3}],AttributeModifiers:[{AttributeName:"minecraft:generic.attack_damage",Name:"kitpvp.mars_damage",Amount:-2,Operation:0,UUID:[I;70,0,0,1],Slot:"mainhand"},{AttributeName:"minecraft:generic.attack_speed",Name:"kitpvp.mars_speed",Amount:-2.4,Operation:0,UUID:[I;70,0,0,2],Slot:"mainhand"}],display:{Name:'{"text":"诅咒剑","color":"dark_red","italic":false}',Lore:['{"text":"被诅咒的剑刃，每第四次命中会让诅咒降临。","color":"dark_purple","italic":false}']}} 1
give @s minecraft:cooked_chicken 24
clear @s minecraft:vex_spawn_egg{KitMarsEgg:1b} 0
give @s minecraft:vex_spawn_egg{KitMarsEgg:1b,EntityTag:{Tags:["kitpvp.mars_token"],CustomName:'{"text":"地鸣"}'},display:{Name:'{"text":"地鸣","color":"dark_red","italic":false}',Lore:['{"text":"一次性：召唤巨人。","color":"dark_purple","italic":false}']}} 1
scoreboard players set @s kitpvp.mars_curse 0

tellraw @s [{"text":"已选择 ","color":"gray"},{"text":"火星","color":"dark_red","bold":true}]
playsound minecraft:ui.button.click master @s ~ ~ ~ 1 1.2
