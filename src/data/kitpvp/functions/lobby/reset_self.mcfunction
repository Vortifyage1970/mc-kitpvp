# ===== 主大厅：初始化"我自己" =====
# 由 [初始化我] 聊天按钮触发：clickEvent.run_command 由点击者执行，@s 即点击者
#
# 清场就一步，clear_player 已包含职业分数清零

function kitpvp:util/clear_player

title @s times 5 30 10
title @s title {"text":"已重置","color":"green","bold":true}
playsound minecraft:block.note_block.pling master @s ~ ~ ~ 1 1.5