# ===== 地图选择菜单 =====
# 由 lobby/menu 的 [选择地图] 按钮触发
# 新增地图时，按 [ 沙漠 ] 的格式复制一行，把 run_command 指向新函数

tellraw @s [{"text":"═══════ 选择地图 ═══════","color":"gold","bold":true}]
tellraw @s [{"text":"[ 沙漠 ]","color":"yellow","bold":true,"clickEvent":{"action":"run_command","value":"/function kitpvp:map/select_desert"},"hoverEvent":{"action":"show_text","contents":[{"text":"经典沙漠地图","color":"gray"}]}}]
tellraw @s [{"text":"[ 竞技场 ]","color":"red","bold":true,"clickEvent":{"action":"run_command","value":"/function kitpvp:map/select_arena"},"hoverEvent":{"action":"show_text","contents":[{"text":"对称竞技场地图","color":"gray"}]}}]
tellraw @s [{"text":"[ 地球 ]","color":"green","bold":true,"clickEvent":{"action":"run_command","value":"/function kitpvp:map/select_earth"},"hoverEvent":{"action":"show_text","contents":[{"text":"围绕地球的地图","color":"gray"}]}}]
tellraw @s [{"text":"[ 返回 ]","color":"gray","clickEvent":{"action":"run_command","value":"/function kitpvp:lobby/menu"},"hoverEvent":{"action":"show_text","contents":[{"text":"返回主菜单","color":"gray"}]}}]
tellraw @s [{"text":"═════════════════════","color":"gold","bold":true}]
