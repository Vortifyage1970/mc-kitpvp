# 罐子自测第二步：用 kill 打死测试罐子（kill 也是把 Health 打到 0，和被打死走同一条路）
tellraw @a [{"text":"[罐子测试] 现在 kill 它，下一行应该是罐子碎的自报","color":"gold"}]
kill @e[tag=kitpvp.debug_jar]
schedule function kitpvp:debug/jar_test_c 5t replace
