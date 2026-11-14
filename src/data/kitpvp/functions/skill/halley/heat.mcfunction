# 被动 1：温度升高 —— 每 45 秒（2700 刻）聊天栏提示，15 秒（300 刻）后受瞬间伤害 II
# pending：-1 空闲 / 300..1 倒计时 / 到 0 结算一次
scoreboard players add @s kitpvp.halley_heat 1
execute if score @s kitpvp.halley_heat matches 2700.. run function kitpvp:skill/halley/heat_warn
execute if score @s kitpvp.halley_pending matches 1.. run scoreboard players remove @s kitpvp.halley_pending 1
execute if score @s kitpvp.halley_pending matches 0 run function kitpvp:skill/halley/burn
