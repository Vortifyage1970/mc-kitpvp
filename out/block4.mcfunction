# ===== 主大厅：取消准备状态 =====
# 调用方：lobby/ready_toggle
# @s = 玩家

tag @s remove kitpvp.ready

# 清掉"已准备"版钓竿，再让 give_items 按当前 tag 状态重发普通版
clear @s minecraft:carrot_on_a_stick{KitLobbyRod:1b}
function kitpvp:lobby/give_items

title @s actionbar {"text":"已取消准备","color":"gray"}
playsound minecraft:block.note_block.bass master @s ~ ~ ~ 1 0.8
