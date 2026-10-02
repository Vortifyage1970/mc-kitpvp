# 玩家进入大厅
# ===== 进入主大厅 =====
# 触发时机：玩家进入服务器、一局结束后回到大厅

# 核心：标记"在大厅"
tag @s add kitpvp.in_lobby


# --- 大厅状态（按需取消注释）---
gamemode adventure @s
clear @s
effect clear @s
spawnpoint @s 0 64 0
function kitpvp:lobby/spawn
function kitpvp:lobby/menu
# 进入大厅：清掉准备状态、吞掉历史右键快照、发放大厅物品                                                                               
# 快照必须在发物品之前推，否则进大厅那一刻会被历史 used 误判                                                                           
tag @s remove kitpvp.ready                                                                                                             
tag @s remove kitpvp.ready_pending                                                                                                     
scoreboard players operation @s kitpvp.ready_last = @s kitpvp.ready_used                                                               
function kitpvp:lobby/give_items