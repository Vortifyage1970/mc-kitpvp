# ===== 地图选择菜单 =====
# 由 lobby/menu 的 [选择地图] 按钮触发
# 新增地图时，按 [ 沙漠 ] 的格式复制一行，把 run_command 指向新函数
# [ 随机 ]：把 #global kitpvp.map 设为 0（0 = 未指定 / 随机），
#           真正的抽取由 map/random 或开局逻辑处理
# 地图是全局设置，统一写在 #global 上，不要写 @s

tellraw @s [{"text":"═══════ 选择地图 ═══════","color":"gold","bold":true}]
tellraw @s [{"text":"[ 沙漠 ]","color":"yellow","bold":true,"clickEvent":{"action":"run_command","value":"/function kitpvp:map/select_desert"},"hoverEvent":{"action":"show_text","contents":[{"text":"经典沙漠地图","color":"gray"}]}}]
tellraw @s [{"text":"[ 竞技场 ]","color":"red","bold":true,"clickEvent":{"action":"run_command","value":"/function kitpvp:map/select_arena"},"hoverEvent":{"action":"show_text","contents":[{"text":"对称竞技场地图","color":"gray"}]}}]
tellraw @s [{"text":"[ 地球 ]","color":"green","bold":true,"clickEvent":{"action":"run_command","value":"/function kitpvp:map/select_earth"},"hoverEvent":{"action":"show_text","contents":[{"text":"围绕地球的地图","color":"gray"}]}}]
tellraw @s [{"text":"[ 西安 ]","color":"gold","bold":true,"clickEvent":{"action":"run_command","value":"/function kitpvp:map/select_xian"},"hoverEvent":{"action":"show_text","contents":[{"text":"围绕西安的地图","color":"gray"}]}}]
tellraw @s [{"text":"[ 随机 ]","color":"light_purple","bold":true,"clickEvent":{"action":"run_command","value":"/scoreboard players set #global kitpvp.map 0"},"hoverEvent":{"action":"show_text","contents":[{"text":"随机地图","color":"gray"}]}}]
tellraw @s [{"text":"[ 返回 ]","color":"gray","clickEvent":{"action":"run_command","value":"/function kitpvp:lobby/menu"},"hoverEvent":{"action":"show_text","contents":[{"text":"返回主菜单","color":"gray"}]}}]
tellraw @s [{"text":"═════════════════════","color":"gold","bold":true}]

