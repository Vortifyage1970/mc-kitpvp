# 恶魔形态令牌补货：冷却走完、手上与 16 格内地上都没有才发（自愈口径，见 04 §四）
execute unless data entity @s Inventory[{tag:{KitCivilDemon:1b}}] unless entity @e[type=minecraft:item,nbt={Item:{tag:{KitCivilDemon:1b}}},distance=..16] run function kitpvp:skill/civil/give_demon_token
