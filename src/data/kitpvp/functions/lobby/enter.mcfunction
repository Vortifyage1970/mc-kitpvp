# 玩家进入大厅
# ===== 进入主大厅 =====
# 触发时机：玩家进入服务器、一局结束后回到大厅

# 核心：标记"在大厅"
tag @s add kitpvp.in_lobby

# --- 大厅状态（按需取消注释）---
gamemode adventure @s
clear @s
effect clear @s
function kitpvp:lobby/spawn
function kitpvp:lobby/menu