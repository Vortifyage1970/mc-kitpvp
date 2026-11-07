# 罐子自测第三步：数 10 格内的生灵，看罐子到底有没有摇出东西
scoreboard players set #jt_n kitpvp.game 0
scoreboard players set #jt_m kitpvp.game 0
execute store result score #jt_n kitpvp.game if entity @e[tag=kitpvp.earth_minion,distance=..10]
execute store result score #jt_m kitpvp.game if entity @e[tag=kitpvp.earth_minion_new,distance=..10]
tellraw @a [{"text":"[罐子测试] 10 格内的生灵 = ","color":"gray"},{"score":{"name":"#jt_n","objective":"kitpvp.game"}},{"text":"　本次新生 = ","color":"gray"},{"score":{"name":"#jt_m","objective":"kitpvp.game"}}]
