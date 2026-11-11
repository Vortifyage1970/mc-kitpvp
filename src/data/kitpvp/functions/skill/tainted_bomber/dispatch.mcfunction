# 里·炸弹兵：同样共用蘑菇牛蛋，按载体 tag 分流；没有假核弹分支
scoreboard players operation @s kitpvp.bomb_last = @s kitpvp.bomb_used

execute at @s if entity @e[type=minecraft:mooshroom,tag=kitpvp.bomb_small_token,distance=..16] run function kitpvp:skill/tainted_bomber/small_cast
execute at @s if entity @e[type=minecraft:mooshroom,tag=kitpvp.bomb_big_token,distance=..16] run function kitpvp:skill/tainted_bomber/big_cast
execute at @s if entity @e[type=minecraft:mooshroom,tag=kitpvp.bomb_track_token,distance=..16] run function kitpvp:skill/tainted_bomber/track_cast
execute at @s if entity @e[type=minecraft:mooshroom,tag=kitpvp.bomb_nuke_token,distance=..16] run function kitpvp:skill/tainted_bomber/nuke_cast
