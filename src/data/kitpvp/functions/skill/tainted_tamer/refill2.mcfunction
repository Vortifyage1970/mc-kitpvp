# 冷却走完补货：整套都不在才补满（同 refill1）
execute unless data entity @s Inventory[{tag:{KitTtGroup2:1b}}] unless entity @e[type=minecraft:item,nbt={Item:{tag:{KitTtGroup2:1b}}},distance=..16] run function kitpvp:skill/tainted_tamer/restock2
