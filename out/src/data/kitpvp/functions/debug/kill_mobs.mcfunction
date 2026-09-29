# ===== 清除调试怪物 =====
# 只清打了 tag kitpvp.debug_mob 的实体，不影响其他生物

kill @e[tag=kitpvp.debug_mob]
tellraw @s [{"text":"[调试] 已清除所有调试怪物","color":"red"}]
