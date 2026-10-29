# 首行无条件推进快照，漏写会每刻连发
scoreboard players operation @s kitpvp.earth_last = @s kitpvp.earth_used

# 蛋一用就会刷出一只带 earth_token 的山羊（只是载体）：以最近载体的位置生成生灵，再清掉载体
# 保持 @s 为使用者，只把执行位置移到刷怪蛋落点
# 冷却只限制补货，不限制已有的召唤蛋；被别人丢弃的蛋也照常能用
execute at @e[type=minecraft:goat,tag=kitpvp.earth_token,distance=..16,sort=nearest,limit=1] run function kitpvp:skill/earth/summon
# 载体被秒杀 / 掉出世界时退回玩家脚下，别让一枚蛋白耗
execute unless entity @e[type=minecraft:goat,tag=kitpvp.earth_token,distance=..16] at @s run function kitpvp:skill/earth/summon
kill @e[type=minecraft:goat,tag=kitpvp.earth_token,distance=..16]
