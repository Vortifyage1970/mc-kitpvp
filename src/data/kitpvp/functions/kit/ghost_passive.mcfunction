# 永久被动；死亡会清空药水效果，重生由 player/after_death 重挂
# 高等级临时效果到期后会自动回落到本函数的 I 级（见 05 §五）
effect give @s minecraft:speed infinite 0 true
effect give @s minecraft:invisibility infinite 0 true
