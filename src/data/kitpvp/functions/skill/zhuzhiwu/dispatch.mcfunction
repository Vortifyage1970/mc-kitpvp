# 辞令令牌入口（盔甲架蛋只此职业发放）：首行无条件推进快照，再按载体 tag 分流
scoreboard players operation @s kitpvp.cizhi_last = @s kitpvp.cizhi_used

execute at @s if entity @e[type=minecraft:sniffer,tag=kitpvp.cizhi_token,distance=..8] run function kitpvp:skill/zhuzhiwu/cizhi_cast
