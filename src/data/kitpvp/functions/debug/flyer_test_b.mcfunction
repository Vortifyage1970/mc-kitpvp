# 由 debug/flyer_test 排程 2 刻后调用，别直接跑
execute as @p at @s run function kitpvp:summon/earth_flyer
tag @e[tag=kitpvp.earth_flyer_carrier,limit=1] add kitpvp.fl_test
scoreboard players set #fl_watch kitpvp.game 24
tellraw @a [{"text":"[飞行器] 已召在头顶，开始采样 24 秒（Y 应该每 10 秒明显掉一截）","color":"gold"}]
schedule function kitpvp:debug/flyer_watch 1t replace
