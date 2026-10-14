# 令牌与战士魂石共用 blaze_spawn_egg，靠生成生物的自定义名分流；distance 8 覆盖刷怪蛋右键射程
# 首行推进快照，漏写会每刻重复触发
scoreboard players operation @s kitpvp.taint_core_last = @s kitpvp.taint_core_used

execute if score @s kitpvp.kit matches 24 at @s if entity @e[type=minecraft:blaze,name="熔火核心",distance=..8] run function kitpvp:skill/taint_archer/core_fire
