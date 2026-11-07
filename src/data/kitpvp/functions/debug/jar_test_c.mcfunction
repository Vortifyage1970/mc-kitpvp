# 罐子自测第三步：数守卫、数新生，和死之前对比
scoreboard players set #jt_n kitpvp.game 0
execute as @p at @s store result score #jt_n kitpvp.game if entity @e[tag=kitpvp.earth_minion,distance=..10]
scoreboard players set #jt_c kitpvp.game 0
execute store result score #jt_c kitpvp.game if entity @e[tag=kitpvp.earth_jar]
scoreboard players set #jt_g kitpvp.game 0
execute store result score #jt_g kitpvp.game if entity @e[tag=kitpvp.earth_jar_guard]
tellraw @a [{"text":"[罐子测试] 死之后：罐子 = ","color":"gray"},{"score":{"name":"#jt_c","objective":"kitpvp.game"}},{"text":"  守卫 = ","color":"gray"},{"score":{"name":"#jt_g","objective":"kitpvp.game"}},{"text":"  10 格内生灵 = ","color":"gray"},{"score":{"name":"#jt_n","objective":"kitpvp.game"}},{"text":"（死之前 = ","color":"gray"},{"score":{"name":"#jt_before","objective":"kitpvp.game"}},{"text":"）","color":"gray"}]
