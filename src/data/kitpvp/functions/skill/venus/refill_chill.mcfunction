# 冷却走完补回令牌：手上与 16 格内地上都没有才发（自愈口径，见 04 §四）
execute unless data entity @s Inventory[{tag:{KitVenusChill:1b}}] unless entity @e[type=minecraft:item,nbt={Item:{tag:{KitVenusChill:1b}}},distance=..16] run function kitpvp:skill/venus/give_chill
