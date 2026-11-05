# 木星劈雷自测：站在平地上执行 /function kitpvp:debug/jupiter_test
# 会在你脚下召唤一只木星，然后立刻用 /damage 把它打死（/damage 是 1.19.4+ 的命令，1.20.1 有）
# 为什么不用 /kill：/kill 是直接把实体抹掉（discard），没有死亡动画、也没有 Health=0 的那一帧
# 步骤：1) 跑这个  2) 等 2 秒  3) 跑 /function kitpvp:debug/jupiter_state 把聊天框内容发我
execute at @s run function kitpvp:summon/earth_jupiter
damage @e[type=minecraft:zombie,tag=kitpvp.earth_jupiter,distance=..3,sort=nearest,limit=1] 100 minecraft:generic
tellraw @s [{"text":"[木星自测] 已召唤并打死。2 秒后跑 "},{"text":"/function kitpvp:debug/jupiter_state","color":"aqua"},{"text":" 看状态","color":"gray"}]
