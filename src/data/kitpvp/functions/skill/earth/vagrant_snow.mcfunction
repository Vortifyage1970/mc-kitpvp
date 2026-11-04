# 流浪汉的口水：5 秒（100 刻）细雪。真正铺块的逻辑在 snow_place，术战士的剑也用同一个（10 秒 = 200 刻）
scoreboard players set #snow_time kitpvp.game 100
execute at @s run function kitpvp:skill/earth/snow_place
