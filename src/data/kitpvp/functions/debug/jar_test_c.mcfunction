# 罐子自测第三步：再数一次 10 格内的生灵，和死之前对比
scoreboard players set #jt_n kitpvp.game 0
execute as @p at @s store result score #jt_n kitpvp.game if entity @e[tag=kitpvp.earth_minion,distance=..10]
tellraw @a [{"text":"[罐子测试] 死之后，10 格内生灵 = ","color":"gray"},{"score":{"name":"#jt_n","objective":"kitpvp.game"}},{"text":"　（死之前 = ","color":"gray"},{"score":{"name":"#jt_before","objective":"kitpvp.game"}},{"text":"）","color":"gray"}]
