# 罐子自测第二步：用 damage 打死测试罐子（走真实受伤路径）
tellraw @a [{"text":"[罐子测试] 现在 damage 打死它，下一行应该是罐子碎的自报","color":"gold"}]
execute as @e[tag=kitpvp.earth_jar] at @s run damage @s 100 minecraft:generic
scoreboard players set #jt_c0 kitpvp.game 0
execute store result score #jt_c0 kitpvp.game if entity @e[tag=kitpvp.earth_jar]
tellraw @a [{"text":"[罐子测试] 打完当刻：罐子 = ","color":"gray"},{"score":{"name":"#jt_c0","objective":"kitpvp.game"}}]
schedule function kitpvp:debug/jar_test_c 5t replace
