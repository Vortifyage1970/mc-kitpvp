# 5 层满了：1.12.2 原样的诅咒套餐（缓慢 III / 虚弱 / 凋零 II / 失明 / 瞬间伤害 / 漂浮）
scoreboard players set @s kitpvp.mars_curse 0
effect give @s minecraft:slowness 10 2 true
effect give @s minecraft:weakness 10 0 true
effect give @s minecraft:wither 10 0 true
effect give @s minecraft:blindness 10 0 true
effect give @s minecraft:instant_damage 1 0 true
effect give @s minecraft:levitation 5 0 true
particle minecraft:soul_fire_flame ~ ~1 ~ 0.6 0.6 0.6 0.15 40 normal
particle minecraft:large_smoke ~ ~1 ~ 0.6 0.6 0.6 0.1 30 normal
playsound minecraft:entity.wither.spawn master @a ~ ~ ~ 0.7 1.6
title @s actionbar {"text":"诅咒降临","color":"dark_red"}
