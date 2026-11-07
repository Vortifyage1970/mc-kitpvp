# 罐子自测第三步：数尸体、数生灵，和死之前对比
scoreboard players set #jt_n kitpvp.game 0
execute as @p at @s store result score #jt_n kitpvp.game if entity @e[tag=kitpvp.earth_minion,distance=..10]
scoreboard players set #jt_c kitpvp.game 0
execute store result score #jt_c kitpvp.game if entity @e[tag=kitpvp.debug_jar]
scoreboard players set #jt_h kitpvp.game -999
execute store result score #jt_h kitpvp.game run data get entity @e[tag=kitpvp.debug_jar,limit=1] Health
tellraw @a [{"text":"[罐子测试] 死之后：尸体 = ","color":"gray"},{"score":{"name":"#jt_c","objective":"kitpvp.game"}},{"text":"  Health = ","color":"gray"},{"score":{"name":"#jt_h","objective":"kitpvp.game"}},{"text":"  10 格内生灵 = ","color":"gray"},{"score":{"name":"#jt_n","objective":"kitpvp.game"}},{"text":"（死之前 = ","color":"gray"},{"score":{"name":"#jt_before","objective":"kitpvp.game"}},{"text":"）","color":"gray"}]
