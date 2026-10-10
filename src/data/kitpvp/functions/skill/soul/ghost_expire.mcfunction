# ===== 幽灵魂石：隐身 20 秒到期 =====
# 调用方：tick.mcfunction
# @s = 使用者
#
# 只摘激活标记、复位召唤冷却。

tag @s remove kitpvp.soul_ghost_active
scoreboard players set @s kitpvp.ghost_minion_cd 0
effect clear @e[type=skeleton,tag=kitpvp.ghost_minion]