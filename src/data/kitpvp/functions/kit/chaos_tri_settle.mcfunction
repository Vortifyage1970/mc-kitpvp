# 三叉戟已经不在飞了（落地/回来/超时）：这时候才真正扣一次
scoreboard players set @s kitpvp.chaos_tri_pending 0
scoreboard players set @s kitpvp.chaos_tri_wait 0
execute if entity @s[tag=kitpvp.chaos_tri] run function kitpvp:kit/chaos_use
