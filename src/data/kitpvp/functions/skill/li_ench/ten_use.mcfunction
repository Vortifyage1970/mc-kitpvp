# 十连蛋被用掉：推进快照、清掉刷出来的熊猫、进入十连
scoreboard players operation @s kitpvp.li_ten_last = @s kitpvp.li_ten_used
execute at @s run kill @e[type=minecraft:panda,distance=..8]
function kitpvp:skill/li_ench/ten_draw
