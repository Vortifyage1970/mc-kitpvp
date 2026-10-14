# 装备必须与 summon/turret 的 ArmorItems / HandItems 保持一致
item replace entity @s armor.head with minecraft:iron_block
item replace entity @s armor.chest with minecraft:iron_chestplate
item replace entity @s armor.legs with minecraft:iron_leggings
item replace entity @s armor.feet with minecraft:iron_boots
item replace entity @s weapon.mainhand with minecraft:bow{Enchantments:[{id:"minecraft:power",lvl:1},{id:"minecraft:punch",lvl:1}]}

effect clear @s minecraft:resistance

tag @s remove kitpvp.turret_molten
scoreboard players set @s kitpvp.turret_molten_timer 0
