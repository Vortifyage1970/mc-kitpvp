# 五种令牌共用蘑菇牛蛋：蛋刷出的隐形载体带不同 tag，按 tag 分流（同 skill/soul/dispatch_warrior）
# 首行无条件推进快照：五种共用同一个 used 计数，漏写会每刻连发
scoreboard players operation @s kitpvp.bomb_last = @s kitpvp.bomb_used

execute at @s if entity @e[type=minecraft:mooshroom,tag=kitpvp.bomb_small_token,distance=..16] run function kitpvp:skill/bomber/small_cast
execute at @s if entity @e[type=minecraft:mooshroom,tag=kitpvp.bomb_big_token,distance=..16] run function kitpvp:skill/bomber/big_cast
execute at @s if entity @e[type=minecraft:mooshroom,tag=kitpvp.bomb_fake_token,distance=..16] run function kitpvp:skill/bomber/fake_cast
execute at @s if entity @e[type=minecraft:mooshroom,tag=kitpvp.bomb_track_token,distance=..16] run function kitpvp:skill/bomber/track_cast
execute at @s if entity @e[type=minecraft:mooshroom,tag=kitpvp.bomb_nuke_token,distance=..16] run function kitpvp:skill/bomber/nuke_cast
