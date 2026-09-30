# ===== 坦克：盾牌到期收回 =====
# 触发：tick 检测到 tag=kitpvp.shield_ready 且 cd2=0
# @s = 盾牌到期的坦克

# 1. 收回盾（背包任意位置都清）
clear @s minecraft:shield{KitShield:1b}

# 2. 摘标记 + 清计时
tag @s remove kitpvp.shield_ready
scoreboard players set @s kitpvp.cd2 0

# 3. 反馈
title @s actionbar {"text":"盾牌已收回","color":"gray"}
