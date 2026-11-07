# 由 debug/flyer_test 排程 2 刻后调用，别直接跑
execute as @p at @s run function kitpvp:summon/earth_flyer
scoreboard players set #fl_watch kitpvp.game 8
tellraw @a [{"text":"[飞行器] 已召在头顶，开始采样 16 秒（Y 应该每 10 秒明显掉一截）","color":"gold"}]
schedule function kitpvp:debug/flyer_watch 20t replace
