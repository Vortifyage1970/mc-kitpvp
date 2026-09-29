# ===== 关闭调试无敌 =====

tag @s remove kitpvp.debug_god
effect clear @s minecraft:resistance
tellraw @s [{"text":"[调试] 无敌已关闭","color":"red"}]
