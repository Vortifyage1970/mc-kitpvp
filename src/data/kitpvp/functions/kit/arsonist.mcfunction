# 纵火狂（kit = 5）；燃烧瓶本体是无效果的喷溅水瓶，只靠 display.Name 与颜色区分
function kitpvp:util/clear_player

scoreboard players set @s kitpvp.kit 5
tag @s add kitpvp.selected

item replace entity @s armor.head with minecraft:leather_helmet{Unbreakable:1b,display:{color:11546150},Enchantments:[{id:"minecraft:fire_protection",lvl:3}]}
item replace entity @s armor.chest with minecraft:leather_chestplate{Unbreakable:1b,display:{color:11546150},Enchantments:[{id:"minecraft:fire_protection",lvl:3}]}
# 写 AttributeModifiers 会整体取代该物品默认修饰符；护腿护甲 5 → 4 是刻意的削弱
item replace entity @s armor.legs with minecraft:iron_leggings{Unbreakable:1b,Enchantments:[{id:"minecraft:fire_protection",lvl:3}],AttributeModifiers:[{AttributeName:"generic.armor",Name:"generic.armor",Amount:4,Operation:0,UUID:[I;5,0,0,3],Slot:"legs"}]}
item replace entity @s armor.feet with minecraft:iron_boots{Unbreakable:1b,Enchantments:[{id:"minecraft:fire_protection",lvl:3}]}

item replace entity @s weapon.mainhand with minecraft:stone_sword{Unbreakable:1b,Enchantments:[{id:"minecraft:fire_aspect",lvl:2}]}

give @s minecraft:cooked_beef 24
give @s minecraft:flint_and_steel 1

scoreboard players set @s kitpvp.cd 0
give @s minecraft:splash_potion{KitFireBomb:1b,CustomPotionColor:16750848,display:{Name:'{"text":"燃烧瓶","color":"gold","bold":true}'}} 2
