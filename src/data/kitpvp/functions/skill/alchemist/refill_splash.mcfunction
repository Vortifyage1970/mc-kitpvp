# 冷却走完补货。四种全空 = 上一套已经用掉；零散丢失也自愈（见 04 §四）
# 地上 16 格内已有同类掉落时视为"没丢"，避免把药剂丢远处再领一套
execute unless data entity @s Inventory[{tag:{KitAlchemistPotion:1b}}] unless entity @e[type=minecraft:item,nbt={Item:{tag:{KitAlchemistPotion:1b}}},distance=..16] run function kitpvp:skill/alchemist/refill_full

execute unless data entity @s Inventory[{tag:{KitAlchemistSpeed:1b}}] unless entity @e[type=minecraft:item,nbt={Item:{tag:{KitAlchemistSpeed:1b}}},distance=..16] run function kitpvp:skill/alchemist/give_speed
execute unless data entity @s Inventory[{tag:{KitAlchemistRegen:1b}}] unless entity @e[type=minecraft:item,nbt={Item:{tag:{KitAlchemistRegen:1b}}},distance=..16] run function kitpvp:skill/alchemist/give_regen
execute unless data entity @s Inventory[{tag:{KitAlchemistJump:1b}}] unless entity @e[type=minecraft:item,nbt={Item:{tag:{KitAlchemistJump:1b}}},distance=..16] run function kitpvp:skill/alchemist/give_jump
execute unless data entity @s Inventory[{tag:{KitAlchemistInvis:1b}}] unless entity @e[type=minecraft:item,nbt={Item:{tag:{KitAlchemistInvis:1b}}},distance=..16] run function kitpvp:skill/alchemist/give_invis
