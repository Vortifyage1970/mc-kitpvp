# ===== 回满血 =====
# 1.20.1 无 /heal，用 instant_health amplifier 5 (level 6) 回满
# saturation amplifier 10 顺带补饱食度

effect give @s minecraft:instant_health 1 5 true
effect give @s minecraft:saturation 1 10 true
tellraw @s [{"text":"[调试] 已回满血","color":"green"}]