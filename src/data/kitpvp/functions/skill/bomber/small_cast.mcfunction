# 小炸弹：用掉就进 10 秒（200 刻）补货计时；满仓用掉一个也一样，不会当场补
# 令牌是消耗品，冷却只卡补货；计时中再用不重置（cd<=0 守卫，同纵火狂）
execute if score @s kitpvp.bomb_small_cd matches ..0 run scoreboard players set @s kitpvp.bomb_small_cd 200
execute at @e[type=minecraft:mooshroom,tag=kitpvp.bomb_small_token,distance=..16,sort=nearest,limit=1] run function kitpvp:summon/bomber_small
execute at @s run kill @e[type=minecraft:mooshroom,tag=kitpvp.bomb_small_token,distance=..16]
