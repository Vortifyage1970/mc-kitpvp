# 罐子自测第二步：用 damage 打死测试罐子（走真实受伤 / 死亡动画这条路，kill 会直接 discard、没有尸体）
tellraw @a [{"text":"[罐子测试] 现在 damage 打死它，中间应该出现罐子碎的自报","color":"gold"}]
execute as @e[tag=kitpvp.debug_jar] at @s run damage @s 100 minecraft:generic
schedule function kitpvp:debug/jar_test_c 5t replace
