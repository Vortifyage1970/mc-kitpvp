# 测试凤凰：不消耗召唤蛋、也不吃补货冷却，直接在脚下召一只并补上归属
# 用法：/reload 之后 /function kitpvp:debug/phoenix_test
execute as @p at @s run function kitpvp:summon/earth_phoenix
execute as @p at @s run function kitpvp:skill/earth/link
tellraw @a [{"text":"[凤凰测试] 打死它 → 原地留下一颗「凤凰蛋」→ 10 秒后同位置复活一次；第二次死就真死（守卫自己消失）","color":"gold"}]
tellraw @a [{"text":"[凤凰测试] 复活的那只已经算过复活次数，不会再留蛋；如果看不到蛋，先 /function kitpvp:debug/phoenix_check","color":"gray"}]
