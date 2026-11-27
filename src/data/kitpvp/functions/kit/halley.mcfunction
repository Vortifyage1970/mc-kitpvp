# 哈雷彗星（kit = 69）：钻石头盔/靴子 + 金胸甲/护腿 + 铁剑；食物金胡萝卜 x24
# 护甲 3+5+3+(3+1)=15，韧性 +2（钻石靴用 AttributeModifiers 补 +1 甲 / +2 韧，外观仍是钻石靴）
# 被动 1 温度升高（skill/halley/heat）、被动 2 近身加速（skill/halley/near）都在 tick 里驱动
function kitpvp:util/clear_player

scoreboard players set @s kitpvp.kit 69
tag @s add kitpvp.selected
scoreboard players set @s kitpvp.alive 1
scoreboard players set @s kitpvp.lives 3

item replace entity @s armor.head with minecraft:diamond_helmet{Unbreakable:1b,Trim:{material:"minecraft:amethyst",pattern:"minecraft:dune"}}
item replace entity @s armor.chest with minecraft:golden_chestplate{Unbreakable:1b,Trim:{material:"minecraft:amethyst",pattern:"minecraft:dune"}}
item replace entity @s armor.legs with minecraft:golden_leggings{Unbreakable:1b,Trim:{material:"minecraft:amethyst",pattern:"minecraft:dune"}}
item replace entity @s armor.feet with minecraft:diamond_boots{Unbreakable:1b,AttributeModifiers:[{AttributeName:"minecraft:generic.armor",Name:"kitpvp.halley_armor",Amount:1,Operation:0,UUID:[I;69,0,0,9],Slot:"feet"},{AttributeName:"minecraft:generic.armor_toughness",Name:"kitpvp.halley_tough",Amount:2,Operation:0,UUID:[I;69,0,0,10],Slot:"feet"}],Trim:{material:"minecraft:amethyst",pattern:"minecraft:dune"}}

item replace entity @s weapon.mainhand with minecraft:iron_sword{Unbreakable:1b}

give @s minecraft:golden_carrot 24

# 令牌：上限 4，先清再发（幂等）
clear @s minecraft:magma_cube_spawn_egg{KitHalleyEgg:1b} 0
function kitpvp:skill/halley/give_egg
function kitpvp:skill/halley/give_egg
function kitpvp:skill/halley/give_egg
function kitpvp:skill/halley/give_egg
scoreboard players set @s kitpvp.halley_cd 0
scoreboard players set @s kitpvp.halley_heat 0
scoreboard players set @s kitpvp.halley_pending -1

tellraw @s [{"text":"已选择 ","color":"gray"},{"text":"哈雷彗星","color":"gold","bold":true}]
playsound minecraft:ui.button.click master @s ~ ~ ~ 1 1.2
