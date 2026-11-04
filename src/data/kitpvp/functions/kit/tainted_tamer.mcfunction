# 里·驯兽师（kit = 30）：锁链套（耐久 III / 无法破坏）+ 石剑；两套召唤蛋分别走 15 秒 / 60 秒冷却
function kitpvp:util/clear_player

scoreboard players set @s kitpvp.kit 30
tag @s add kitpvp.selected
scoreboard players set @s kitpvp.alive 1
scoreboard players set @s kitpvp.lives 3

# 护甲 11：锁链盔默认 2，显式写成 1（写 AttributeModifiers 会覆盖默认修饰符，正好拿来削 1 点）
item replace entity @s armor.head with minecraft:chainmail_helmet{Unbreakable:1b,Enchantments:[{id:"minecraft:unbreaking",lvl:3}],AttributeModifiers:[{AttributeName:"generic.armor",Name:"kitpvp.ttamer_armor_head",Amount:1,Operation:0,UUID:[I;30,0,0,1],Slot:"head"}]}
item replace entity @s armor.chest with minecraft:chainmail_chestplate{Unbreakable:1b,Enchantments:[{id:"minecraft:unbreaking",lvl:3}]}
item replace entity @s armor.legs with minecraft:chainmail_leggings{Unbreakable:1b,Enchantments:[{id:"minecraft:unbreaking",lvl:3}]}
item replace entity @s armor.feet with minecraft:chainmail_boots{Unbreakable:1b,Enchantments:[{id:"minecraft:unbreaking",lvl:3}]}

item replace entity @s weapon.mainhand with minecraft:stone_sword{Unbreakable:1b}
give @s minecraft:cooked_beef 20

scoreboard players set @s kitpvp.cd 0
scoreboard players set @s kitpvp.cd2 0
function kitpvp:skill/tainted_tamer/give1
function kitpvp:skill/tainted_tamer/give2

tellraw @s [{"text":"已选择 ","color":"gray"},{"text":"里·驯兽师","color":"dark_red","bold":true}]
playsound minecraft:ui.button.click master @s ~ ~ ~ 1 1.2
