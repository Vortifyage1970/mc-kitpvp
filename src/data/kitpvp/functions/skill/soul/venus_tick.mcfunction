# @s = 金星魂石的舔狗（每刻被 tick 调一次）
# 每 0.5 秒刷一遍「武装模块」与「制冷模块」：增益续 1 秒，减速光环续 1 秒
execute if score @s kitpvp.soul_next matches ..0 run function kitpvp:skill/soul/venus_buff
execute if score @s kitpvp.soul_next matches 1.. run scoreboard players remove @s kitpvp.soul_next 1
execute if score @s kitpvp.soul_timer matches 1.. run scoreboard players remove @s kitpvp.soul_timer 1
execute if score @s kitpvp.soul_timer matches ..0 run function kitpvp:skill/soul/venus_end
