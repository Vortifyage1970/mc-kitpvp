# 旋转状态 2：环肽成员 1..4 依次站到四个方位
# 坐标是相对"执行位置"的 —— 调用方用 execute at <玩家> 把圈心放在玩家脚下
execute at @s run tp @e[tag=kitpvp.earth_ring_1] ~-2 ~ ~
execute at @s run tp @e[tag=kitpvp.earth_ring_2] ~ ~ ~-2
execute at @s run tp @e[tag=kitpvp.earth_ring_3] ~2 ~ ~
execute at @s run tp @e[tag=kitpvp.earth_ring_4] ~ ~ ~2
