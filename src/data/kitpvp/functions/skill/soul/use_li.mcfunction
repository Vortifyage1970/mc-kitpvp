# 李朱俊泽魂石：首行推进快照（李朱俊泽本人也用 pig 蛋，名字不符时这里什么都不做）
scoreboard players operation @s kitpvp.soul_li_last = @s kitpvp.soul_li_used

execute at @s at @e[type=minecraft:pig,name="李朱俊泽魂石",distance=..8,sort=nearest,limit=1] run function kitpvp:skill/soul/li_apply

execute at @s run kill @e[type=minecraft:pig,name="李朱俊泽魂石",distance=..8]
