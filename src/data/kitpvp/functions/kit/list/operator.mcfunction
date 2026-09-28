# ===== 职业列表：职业职业 =====
# 由 kit/list 的 [职业职业] 按钮触发
# 暂无已实装职业，占位

tellraw @s [{"text":"═══ 职业职业 ═══","color":"aqua","bold":true}]
tellraw @s [{"text":"（暂无职业）","color":"dark_gray","italic":true}]
tellraw @s [{"text":"[返回]","color":"yellow","clickEvent":{"action":"run_command","value":"/function kitpvp:kit/list"},"hoverEvent":{"action":"show_text","contents":[{"text":"回到分类列表","color":"gray"}]}}]