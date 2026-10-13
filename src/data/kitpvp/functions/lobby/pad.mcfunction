# 每刻轮询：踩上职业压力板的瞬间弹一次对应职业卡片，on_pad 做翻转防重复。
# on_pad 是位置状态 tag，刻意不在 clear_player 里清（否则站在板上会被反复触发）。
execute as @a[tag=kitpvp.in_lobby,tag=!kitpvp.spectator,tag=!kitpvp.on_pad] at @s if block ~ ~ ~ minecraft:light_weighted_pressure_plate run function kitpvp:lobby/pad_enter

execute as @a[tag=kitpvp.on_pad] at @s unless block ~ ~ ~ minecraft:light_weighted_pressure_plate run tag @s remove kitpvp.on_pad
