# @s = 太阳魂石的 marker（每刻被 tick 调一次）：每 2 秒给 9 格内玩家一条噪音，20 秒到自毁
execute if score @s kitpvp.soul_next matches ..0 run function kitpvp:skill/soul/sun_noise
execute if score @s kitpvp.soul_next matches 1.. run scoreboard players remove @s kitpvp.soul_next 1
execute if score @s kitpvp.soul_timer matches 1.. run scoreboard players remove @s kitpvp.soul_timer 1
execute if score @s kitpvp.soul_timer matches ..0 run kill @s
