# 冷却走完补货：整套都不在（手上与 16 格内地上都没有）才补满一套，避免"丢一枚换一枚"（见 04 §四）
execute unless data entity @s Inventory[{tag:{KitTtGroup1:1b}}] unless entity @e[type=minecraft:item,nbt={Item:{tag:{KitTtGroup1:1b}}},distance=..16] run function kitpvp:skill/tainted_tamer/restock1
