# @s = 被日蚀锁定的玩家（每刻走一次自己的倒计时）：每 2 秒一条噪音，20 秒到自动结束
# 标记挂在人身上，所以走出 10 格范围也照样被干扰
execute if score @s kitpvp.sun_hit_next matches ..0 run function kitpvp:skill/sun/noise_pick
execute if score @s kitpvp.sun_hit_next matches ..0 run scoreboard players set @s kitpvp.sun_hit_next 40
execute if score @s kitpvp.sun_hit_next matches 1.. run scoreboard players remove @s kitpvp.sun_hit_next 1
execute if score @s kitpvp.sun_hit_timer matches 1.. run scoreboard players remove @s kitpvp.sun_hit_timer 1
execute if score @s kitpvp.sun_hit_timer matches ..0 run tag @s remove kitpvp.sun_hit
