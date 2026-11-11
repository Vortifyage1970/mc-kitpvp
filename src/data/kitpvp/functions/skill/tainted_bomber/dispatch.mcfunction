# 里·炸弹兵：共用蘑菇牛蛋，按载体 tag 分流；没有小炸弹、没有假核弹
scoreboard players operation @s kitpvp.bomb_last = @s kitpvp.bomb_used

execute at @s if entity @e[type=minecraft:mooshroom,tag=kitpvp.bomb_big_token,distance=..16] run function kitpvp:skill/tainted_bomber/big_cast
execute at @s if entity @e[type=minecraft:mooshroom,tag=kitpvp.bomb_track_token,distance=..16] run function kitpvp:skill/tainted_bomber/track_cast
execute at @s if entity @e[type=minecraft:mooshroom,tag=kitpvp.bomb_nuke_token,distance=..16] run function kitpvp:skill/tainted_bomber/nuke_cast

# 捡到表玩家丢的小炸弹 / 假核弹：只清载体，不召唤
execute at @s run kill @e[type=minecraft:mooshroom,tag=kitpvp.bomb_token,distance=..16]
