# ===== 末影人：发放装备（kit=8） =====
# 调用方：util/give_kit

# 1. 清到干净初始状态（会清掉 kit，紧接着写回）
function kitpvp:util/clear_player

# 2. 登记职业
scoreboard players set @s kitpvp.kit 8
tag @s add kitpvp.selected
scoreboard players set @s kitpvp.alive 1

item replace entity @s armor.head with minecraft:leather_helmet{display:{color:8991416},Unbreakable:1b} 1
item replace entity @s armor.chest with minecraft:leather_chestplate{display:{color:8991416},Unbreakable:1b} 1
item replace entity @s armor.legs with minecraft:iron_leggings{Unbreakable:1b} 1
item replace entity @s armor.feet with minecraft:iron_boots{Enchantments:[{id:"minecraft:feather_falling",lvl:3}],Unbreakable:1b} 1
item replace entity @s weapon.mainhand with minecraft:iron_sword{Unbreakable:1b} 1

give @s minecraft:cooked_beef 16
give @s minecraft:chorus_fruit 16

scoreboard players set @s kitpvp.ender_ammo 3
give @s minecraft:ender_pearl{KitEnderPearl:1b} 3
