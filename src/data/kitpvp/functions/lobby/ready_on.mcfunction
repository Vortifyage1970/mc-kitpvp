# ===== 主大厅：进入准备状态 =====
# 调用方：lobby/ready_toggle
# @s = 玩家

tag @s add kitpvp.ready

# 清掉旧钓竿，再让 give_items 按 ready tag 重发一把带附魔光效的"已准备"版
# 两步在同一 tick 内完成，玩家不会看到"钓竿消失一刻"
# 剑已经拿着的话，give_items 的幂等检测会跳过，不会重复给
clear @s minecraft:carrot_on_a_stick{KitLobbyRod:1b}
function kitpvp:lobby/give_items

title @s actionbar {"text":"已准备","color":"gold"}
playsound minecraft:block.note_block.pling master @s ~ ~ ~ 1 1.6

# 检查是否全员就绪 → 决定要不要开局
function kitpvp:lobby/ready_check