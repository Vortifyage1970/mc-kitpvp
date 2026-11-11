# 假核弹：用掉就进 25 秒（500 刻）补货计时（与大炸弹各算各的）
execute if score @s kitpvp.bomb_fake_cd matches ..0 run scoreboard players set @s kitpvp.bomb_fake_cd 500
execute at @e[type=minecraft:mooshroom,tag=kitpvp.bomb_fake_token,distance=..16,sort=nearest,limit=1] run function kitpvp:summon/bomber_fake
execute at @s run kill @e[type=minecraft:mooshroom,tag=kitpvp.bomb_fake_token,distance=..16]
