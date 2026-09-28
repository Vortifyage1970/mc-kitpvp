# ===== 主大厅菜单 =====
# 建议在 lobby/enter 末尾加一行：function kitpvp:lobby/menu
# @s = 点开菜单的玩家
# 所有按钮都给"本人"看，所以 tellraw 用 @s

tellraw @s [{"text":"═══════ 职业战争 ═══════","color":"gold","bold":true}]
tellraw @s [{"text":"[ 选择职业 ]","color":"green","bold":true,"clickEvent":{"action":"run_command","value":"/function kitpvp:kit/list"},"hoverEvent":{"action":"show_text","contents":[{"text":"查看职业介绍并选择","color":"gray"}]}}]
tellraw @s [{"text":"[ 开始游戏 ]","color":"yellow","bold":true,"clickEvent":{"action":"run_command","value":"/function kitpvp:game/start"},"hoverEvent":{"action":"show_text","contents":[{"text":"开始一局游戏","color":"gray"}]}}]
tellraw @s [{"text":"[ 初始化我 ]","color":"red","clickEvent":{"action":"run_command","value":"/function kitpvp:lobby/reset_self"},"hoverEvent":{"action":"show_text","contents":[{"text":"清空背包并重置自身状态","color":"gray"}]}}]
tellraw @s [{"text":"[(暂 时)调试]","color":"dark_red","clickEvent":{"action":"run_command","value":"/function kitpvp:debug/menu"},"hoverEvent":{"action":"show_text","contents":[{"text":"打开调试控制台","color":"gray"}]}}
tellraw @s [{"text":"═════════════════════","color":"gold","bold":true}]