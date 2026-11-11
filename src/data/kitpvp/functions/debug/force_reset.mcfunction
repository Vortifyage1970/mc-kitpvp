# 立刻重置回大厅（不等 end 的 10 秒倒计时收尾）
# schedule clear 只清得掉还没发射的那一次；已经跑完的 end 再 reset 一次是幂等的（见 04 §二.3）
schedule clear kitpvp:game/reset
function kitpvp:game/reset

tellraw @a [{"text":"[debug] ","color":"light_purple","bold":true},{"text":"已强制重置：倒计时作废，回大厅。","color":"white"}]
