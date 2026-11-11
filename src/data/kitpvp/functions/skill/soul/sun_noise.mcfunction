# 2 秒一条噪音：9 格内除自己以外的每个玩家各自随机一条（128 选 1，复用太阳自己的噪音池）
execute at @s as @a[distance=..9,scores={kitpvp.alive=1},tag=!kitpvp.spectator,tag=!kitpvp.soul_sun_owner] run function kitpvp:skill/sun/noise_pick
scoreboard players set @s kitpvp.soul_next 40
