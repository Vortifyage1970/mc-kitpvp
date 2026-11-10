# 金星魂石：首行推进快照（ocelot 蛋只在本魂石里发）
scoreboard players operation @s kitpvp.soul_venus_last = @s kitpvp.soul_venus_used

execute at @s at @e[tag=kitpvp.soul_venus_token,distance=..8,sort=nearest,limit=1] run function kitpvp:skill/soul/venus_apply

execute at @s run kill @e[tag=kitpvp.soul_venus_token]
