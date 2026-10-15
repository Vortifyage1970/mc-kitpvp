# 渔夫（kit = 7）：无被动。护甲与武器数值全部写在 AttributeModifiers 上
# （写了 AttributeModifiers 就会整体覆盖物品默认修饰符，故攻伤与攻速必须写全）
function kitpvp:util/clear_player
scoreboard players set @s kitpvp.kit 7
scoreboard players set @s kitpvp.fisher_no_tri 0
tag @s add kitpvp.selected

item replace entity @s armor.head with minecraft:leather_helmet{Unbreakable:1b,AttributeModifiers:[{AttributeName:"generic.armor",Name:"generic.armor",Amount:2,Operation:0,UUID:[I;7,0,0,1],Slot:"head"}]} 1
item replace entity @s armor.chest with minecraft:elytra{Unbreakable:1b,Enchantments:[{id:"minecraft:protection",lvl:5}]} 1
item replace entity @s armor.legs with minecraft:leather_leggings{Unbreakable:1b,AttributeModifiers:[{AttributeName:"generic.armor",Name:"generic.armor",Amount:4,Operation:0,UUID:[I;7,0,0,3],Slot:"legs"}]} 1
item replace entity @s armor.feet with minecraft:leather_boots{Unbreakable:1b,Enchantments:[{id:"minecraft:depth_strider",lvl:3}],AttributeModifiers:[{AttributeName:"generic.armor",Name:"generic.armor",Amount:2,Operation:0,UUID:[I;7,0,0,4],Slot:"feet"}]} 1

# 三叉戟的 NBT 必须与 skill/fisher_refill 补发的那把完全一致
item replace entity @s weapon.mainhand with minecraft:trident{KitFisherTrident:1b,Unbreakable:1b,Enchantments:[{id:"minecraft:loyalty",lvl:2}],AttributeModifiers:[{AttributeName:"generic.attack_damage",Name:"generic.attack_damage",Amount:6,Operation:0,UUID:[I;7,0,0,5],Slot:"mainhand"},{AttributeName:"generic.attack_speed",Name:"generic.attack_speed",Amount:-3,Operation:0,UUID:[I;7,0,0,6],Slot:"mainhand"}]} 1

give @s minecraft:fishing_rod{Unbreakable:1b,Enchantments:[{id:"minecraft:knockback",lvl:1}]} 1
give @s minecraft:water_bucket 1
give @s minecraft:cooked_beef 24

function kitpvp:skill/fisher/give_egg

title @s actionbar {"text":"已选择：渔夫","color":"blue"}
playsound minecraft:block.note_block.pling master @s ~ ~ ~ 1 1.5
