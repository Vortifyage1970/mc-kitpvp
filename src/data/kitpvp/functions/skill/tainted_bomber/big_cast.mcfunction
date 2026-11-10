# 大炸弹：用掉就进 10 秒（200 刻）补货计时
execute if score @s kitpvp.bomb_big_cd matches ..0 run scoreboard players set @s kitpvp.bomb_big_cd 200
execute at @e[type=minecraft:mooshroom,tag=kitpvp.bomb_big_token,distance=..16,sort=nearest,limit=1] run function kitpvp:summon/bomber_big
execute at @s run kill @e[type=minecraft:mooshroom,tag=kitpvp.bomb_big_token,distance=..16]
