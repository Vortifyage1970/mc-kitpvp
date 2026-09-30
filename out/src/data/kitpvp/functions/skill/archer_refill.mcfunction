# ===== 弓箭手：换弹 =====
# 设计文档：丢出自己的弓并捡起，箭数重置为 12
# @s = 弓箭手本人

# 清空背包里所有箭（包括地图上捡的），再补 12 支
clear @s minecraft:arrow
give @s minecraft:arrow 12

title @s actionbar {"text":"换弹完成：12 支箭","color":"gold"}
playsound minecraft:item.crossbow.loading_end master @s ~ ~ ~ 0.8 1.3
