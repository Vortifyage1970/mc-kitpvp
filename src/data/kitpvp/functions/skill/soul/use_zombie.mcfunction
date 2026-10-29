# 僵尸魂石：逐字符推进快照（漏写会每刻重复触发）
scoreboard players operation @s kitpvp.soul_zombie_last = @s kitpvp.soul_zombie_used

# 载体是「僵尸魂石」的尸壳：只有真的刷出了它才给效果（同名蛋在别处有来源时靠名字分流，见 dispatch_warrior）
execute at @s if entity @e[type=minecraft:husk,name="僵尸魂石",distance=..8] run function kitpvp:skill/soul/zombie_apply

execute at @s run kill @e[type=minecraft:husk,name="僵尸魂石"]
