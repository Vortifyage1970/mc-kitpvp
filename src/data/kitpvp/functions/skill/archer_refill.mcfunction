# ===== 弓箭手：换弹 =====
# 设计文档：丢出自己的弓并捡起，箭数重置为 12
# @s = 弓箭手本人

# 1. 清空背包里所有箭（包括地图上捡的、别人给的）
clear @s minecraft:arrow

# 2. 清掉地上散落的箭物品
#    防止"丢出一支箭 → 换弹 → 再捡回来"把箭数刷过 12
#    注意：会一并清掉地图上其它来源的箭物品
kill @e[type=minecraft:item,nbt={Item:{id:"minecraft:arrow"}}]

# 3. 补满 12 支
give @s minecraft:arrow 12

title @s actionbar {"text":"换弹完成：12 支箭","color":"gold"}
playsound minecraft:item.crossbow.loading_end master @s ~ ~ ~ 0.8 1.3