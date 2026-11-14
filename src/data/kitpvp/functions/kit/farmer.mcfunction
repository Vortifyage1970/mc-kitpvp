# 农夫（kit = 13）：铁锄 + 皮革/铁混甲，靠"耕地 → 麦种 → 小麦 → 面包 → 再生"续航
# 锄头写了 AttributeModifiers 就整体取代默认修饰符，攻速必须一起写（见 04 §九）：实际 5.5 伤害 / 2.0 攻速
function kitpvp:util/clear_player

scoreboard players set @s kitpvp.kit 13
tag @s add kitpvp.selected
scoreboard players set @s kitpvp.alive 1
scoreboard players set @s kitpvp.lives 3

item replace entity @s armor.head with minecraft:leather_helmet{Unbreakable:1b}
item replace entity @s armor.chest with minecraft:iron_chestplate{Unbreakable:1b}
item replace entity @s armor.legs with minecraft:leather_leggings{Unbreakable:1b}
item replace entity @s armor.feet with minecraft:iron_boots{Unbreakable:1b}

item replace entity @s hotbar.0 with minecraft:iron_hoe{KitFarmerHoe:1b,Unbreakable:1b,AttributeModifiers:[{AttributeName:"minecraft:generic.attack_damage",Name:"kitpvp.farmer_hoe",Amount:4.5,Operation:0,UUID:[I;13,0,0,1],Slot:"mainhand"},{AttributeName:"minecraft:generic.attack_speed",Name:"kitpvp.farmer_hoe_speed",Amount:-2.0,Operation:0,UUID:[I;13,0,0,2],Slot:"mainhand"}]}
item replace entity @s hotbar.1 with minecraft:cooked_beef 24
item replace entity @s hotbar.2 with minecraft:crafting_table 4

tellraw @s [{"text":"已选择 ","color":"gray"},{"text":"农夫","color":"yellow","bold":true}]
playsound minecraft:ui.button.click master @s ~ ~ ~ 1 1.2
