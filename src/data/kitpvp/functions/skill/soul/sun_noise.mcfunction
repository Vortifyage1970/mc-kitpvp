# 2 秒一条噪音：10 格内每个参战玩家各自随机一条（128 选 1，复用太阳自己的噪音池）
execute at @s as @a[distance=..10,scores={kitpvp.alive=1},tag=!kitpvp.spectator] run function kitpvp:skill/sun/noise_pick
scoreboard players set @s kitpvp.soul_next 40
