# 单抽蛋被用掉：推进快照、清掉刷出来的山羊、进入单抽
scoreboard players operation @s kitpvp.li_single_last = @s kitpvp.li_single_used
execute at @s run kill @e[type=minecraft:camel,distance=..8]
function kitpvp:skill/li_ench/single_draw
