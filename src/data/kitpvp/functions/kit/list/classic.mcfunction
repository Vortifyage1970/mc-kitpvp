# ===== 职业列表：经典（表） =====
# 由 kit/list 的 [经典（表）] 按钮触发
# 新增职业时，在 [返回] 之前按同格式追加一行

tellraw @s [{"text":"═══ 经典（表） ═══","color":"green","bold":true}]
tellraw @s [{"text":"[战士] ","color":"green","bold":true,"clickEvent":{"action":"run_command","value":"/function kitpvp:kit/info/warrior"},"hoverEvent":{"action":"show_text","contents":[{"text":"铁甲冲锋的正面战士","color":"gray"}]}},{"text":"铁甲冲锋的正面战士","color":"dark_gray"}]
tellraw @s [{"text":"[弓箭手] ","color":"green","bold":true,"clickEvent":{"action":"run_command","value":"/function kitpvp:kit/info/archer"},"hoverEvent":{"action":"show_text","contents":[{"text":"远程消耗的射手","color":"gray"}]}},{"text":"远程消耗的射手","color":"dark_gray"}]
tellraw @s [{"text":"[坦克] ","color":"green","bold":true,"clickEvent":{"action":"run_command","value":"/function kitpvp:kit/info/tank"},"hoverEvent":{"action":"show_text","contents":[{"text":"高护甲低速的肉盾","color":"gray"}]}},{"text":"高护甲低速的肉盾","color":"dark_gray"}]
tellraw @s [{"text":"[刺客] ","color":"green","bold":true,"clickEvent":{"action":"run_command","value":"/function kitpvp:kit/info/assassin"},"hoverEvent":{"action":"show_text","contents":[{"text":"高速突进的暗杀者","color":"gray"}]}},{"text":"高速突进的暗杀者","color":"dark_gray"}]
tellraw @s [{"text":"[返回]","color":"yellow","clickEvent":{"action":"run_command","value":"/function kitpvp:kit/list"},"hoverEvent":{"action":"show_text","contents":[{"text":"回到分类列表","color":"gray"}]}}]