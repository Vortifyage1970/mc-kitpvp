# 进入大厅：清掉准备状态、吞掉历史右键快照、发放大厅物品
# 快照必须在发物品之前推，否则进大厅那一刻会被历史 used 误判
tag @s remove kitpvp.ready
tag @s remove kitpvp.ready_pending
scoreboard players operation @s kitpvp.ready_last = @s kitpvp.ready_used
function kitpvp:lobby/give_items
