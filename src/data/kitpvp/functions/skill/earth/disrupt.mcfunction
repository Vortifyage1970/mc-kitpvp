# @s = 扰动者：每 3 秒，11 格内的玩家只吃一条"看不清"——3 秒反胃——外加随机一条噪音（128 选 1）
# 不再借用太阳耀斑那套 5 秒读屏（中招者头上会挂 kitpvp.sun_flare，那是太阳的私有状态）
execute at @s as @a[distance=..11,scores={kitpvp.alive=1},tag=!kitpvp.spectator] run effect give @s minecraft:nausea 3 0 true
execute at @s as @a[distance=..11,scores={kitpvp.alive=1},tag=!kitpvp.spectator] run function kitpvp:skill/sun/noise_pick
scoreboard players set @s kitpvp.earth_cd_a 60
