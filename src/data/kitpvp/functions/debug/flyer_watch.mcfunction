# 由 debug/flyer_test 或 debug/flyer_probe 启动，每 2 秒打两行，打满 #fl_watch 次自己停
# 第一行：位置与计时；第二行：归属与筛选所需的关键数字（owner / #fl_own / 你的 etid）
execute as @e[tag=kitpvp.earth_flyer_carrier,limit=1] at @s run tellraw @a [{"text":"[飞行器] Y=","color":"aqua"},{"nbt":"Pos[1]","entity":"@s"},{"text":"  cd=","color":"gray"},{"score":{"name":"@s","objective":"kitpvp.earth_cd_a"}},{"text":"  dive=","color":"gray"},{"score":{"name":"@s","objective":"kitpvp.flyer_dive"}}]
execute if entity @a[tag=kitpvp.flyer_target] run tellraw @a [{"text":"           靶子：有","color":"green"}]
execute unless entity @a[tag=kitpvp.flyer_target] run tellraw @a [{"text":"           靶子：没有","color":"red"}]
execute as @e[tag=kitpvp.earth_flyer_carrier,limit=1] at @s run tellraw @a [{"text":"           母体 owner=","color":"gray"},{"score":{"name":"@s","objective":"kitpvp.earth_owner"}},{"text":"  #fl_own=","color":"gray"},{"score":{"name":"#fl_own","objective":"kitpvp.game"}}]
execute as @p at @s run tellraw @a [{"text":"           你 Y=","color":"gray"},{"nbt":"Pos[1]","entity":"@s"},{"text":"  etid=","color":"gray"},{"score":{"name":"@s","objective":"kitpvp.etid"}}]
execute if entity @p[gamemode=spectator] run tellraw @a [{"text":"           ⚠ 你在旁观模式，目标筛选会把你排除","color":"red"}]
scoreboard players remove #fl_watch kitpvp.game 1
execute if score #fl_watch kitpvp.game matches 1.. run schedule function kitpvp:debug/flyer_watch 40t replace
execute if score #fl_watch kitpvp.game matches ..0 run tellraw @a [{"text":"[飞行器] 采样结束","color":"gold"}]
