# 进入主大厅：标记 in_lobby + 大厅状态，并让准备状态与快照归位
tag @s add kitpvp.in_lobby

gamemode adventure @s
clear @s
effect clear @s
spawnpoint @s 0 64 0
function kitpvp:lobby/spawn
function kitpvp:lobby/menu

# 快照必须在发物品之前推，否则进大厅那一刻会被历史 used 误判
tag @s remove kitpvp.ready
tag @s remove kitpvp.ready_pending
scoreboard players operation @s kitpvp.ready_last = @s kitpvp.ready_used
function kitpvp:lobby/give_items
