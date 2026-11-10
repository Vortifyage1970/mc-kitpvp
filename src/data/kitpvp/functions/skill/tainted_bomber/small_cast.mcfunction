# 小炸弹：用掉就进 2 秒（40 刻）补货计时（三枚令牌各算各的）
execute if score @s kitpvp.bomb_small_cd matches ..0 run scoreboard players set @s kitpvp.bomb_small_cd 40
execute at @e[type=minecraft:mooshroom,tag=kitpvp.bomb_small_token,distance=..16,sort=nearest,limit=1] run function kitpvp:summon/bomber_small
execute at @s run kill @e[type=minecraft:mooshroom,tag=kitpvp.bomb_small_token,distance=..16]
