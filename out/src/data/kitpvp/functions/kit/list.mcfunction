# ===== 职业分类列表 =====
# 调用：/function kitpvp:kit/list
# 这一层只列分类，点进分类后才是具体职业
# 新增分类时，按同格式追加一行

tellraw @s [{"text":"═══════ 选择职业 ═══════","color":"gold","bold":true}]
tellraw @s [{"text":"── 分类 ──","color":"yellow","bold":true}]
tellraw @s [{"text":"[经典（表）] ","color":"green","clickEvent":{"action":"run_command","value":"/function kitpvp:kit/list/classic"},"hoverEvent":{"action":"show_text","contents":[{"text":"标准职业，平衡","color":"gray"}]}},{"text":"标准职业，平衡","color":"dark_gray"}]
tellraw @s [{"text":"[经典（里）] ","color":"dark_green","clickEvent":{"action":"run_command","value":"/function kitpvp:kit/list/classic_evil"},"hoverEvent":{"action":"show_text","contents":[{"text":"经典职业的黑暗强化版","color":"gray"}]}},{"text":"经典职业的黑暗强化版","color":"dark_gray"}]
tellraw @s [{"text":"[经典（混沌）] ","color":"dark_purple","clickEvent":{"action":"run_command","value":"/function kitpvp:kit/list/classic_chaos"},"hoverEvent":{"action":"show_text","contents":[{"text":"多职业杂糅，机制复杂","color":"gray"}]}},{"text":"多职业杂糅，机制复杂","color":"dark_gray"}]
tellraw @s [{"text":"[星象] ","color":"blue","clickEvent":{"action":"run_command","value":"/function kitpvp:kit/list/astral"},"hoverEvent":{"action":"show_text","contents":[{"text":"基于星座/天象设计","color":"gray"}]}},{"text":"基于星座/天象设计","color":"dark_gray"}]
tellraw @s [{"text":"[职业职业] ","color":"aqua","clickEvent":{"action":"run_command","value":"/function kitpvp:kit/list/operator"},"hoverEvent":{"action":"show_text","contents":[{"text":"参考明日方舟，机制较复杂","color":"gray"}]}},{"text":"参考明日方舟，机制较复杂","color":"dark_gray"}]
tellraw @s [{"text":"[抽象] ","color":"light_purple","clickEvent":{"action":"run_command","value":"/function kitpvp:kit/list/meme"},"hoverEvent":{"action":"show_text","contents":[{"text":"梗向、搞笑向","color":"gray"}]}},{"text":"梗向、搞笑向","color":"dark_gray"}]
tellraw @s [{"text":"[历史] ","color":"gold","clickEvent":{"action":"run_command","value":"/function kitpvp:kit/list/history"},"hoverEvent":{"action":"show_text","contents":[{"text":"基于历史人物/事件","color":"gray"}]}},{"text":"基于历史人物/事件","color":"dark_gray"}]
tellraw @s [{"text":"[返回]","color":"yellow","clickEvent":{"action":"run_command","value":"/function kitpvp:lobby/menu"},"hoverEvent":{"action":"show_text","contents":[{"text":"回到大厅菜单","color":"gray"}]}}]
