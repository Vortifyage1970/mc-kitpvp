# 由 debug/flyer_test 或 debug/flyer_probe 启动，每秒打一行，打满 #fl_watch 次自己停
execute as @e[tag=kitpvp.earth_flyer_carrier,limit=1] at @s run tellraw @a [{"text":"[飞行器] Y=","color":"aqua"},{"nbt":"Pos[1]","entity":"@s"},{"text":"  cd=","color":"gray"},{"score":{"name":"@s","objective":"kitpvp.earth_cd_a"}},{"text":"  dive=","color":"gray"},{"score":{"name":"@s","objective":"kitpvp.flyer_dive"}}]
execute as @p at @s run tellraw @a [{"text":"           你 Y=","color":"gray"},{"nbt":"Pos[1]","entity":"@s"}]
execute at @p if entity @e[tag=kitpvp.earth_flyer_carrier,distance=..8] run tellraw @a [{"text":"           离你：8 格内","color":"yellow"}]
execute at @p if entity @e[tag=kitpvp.earth_flyer_carrier,distance=8..20] run tellraw @a [{"text":"           离你：8-20 格","color":"yellow"}]
execute at @p if entity @e[tag=kitpvp.earth_flyer_carrier,distance=20..] run tellraw @a [{"text":"           离你：20 格以外","color":"yellow"}]
execute if entity @a[tag=kitpvp.flyer_target] run tellraw @a [{"text":"           靶子：有","color":"green"}]
execute unless entity @a[tag=kitpvp.flyer_target] run tellraw @a [{"text":"           靶子：没有（目标筛选把所有人排除了，这时它不会俯冲）","color":"red"}]
scoreboard players remove #fl_watch kitpvp.game 1
execute if score #fl_watch kitpvp.game matches 1.. run schedule function kitpvp:debug/flyer_watch 20t replace
execute if score #fl_watch kitpvp.game matches ..0 run tellraw @a [{"text":"[飞行器] 采样结束。Y 掉不下去 = 俯冲的 tp 没生效；Y 掉一截又爬回来 = 正常俯冲但幅度小","color":"gold"}]
