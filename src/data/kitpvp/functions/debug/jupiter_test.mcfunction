# 木星劈雷自测：站在平地上执行 /function kitpvp:debug/jupiter_test
# 会在你脚下召唤一只木星，然后立刻用 /damage 把它打死
# 为什么不用 /kill：/kill 是直接把实体抹掉（discard），没有死亡动画、也没有 Health=0 的那一帧，
#   tick 抓不到"尸体"就永远不会劈雷 —— 这是被 /kill 的木星不放雷的原因，不是代码坏了
# 预期：1~2 秒内在木星倒下的位置出现一道雷
execute at @s run function kitpvp:summon/earth_jupiter
damage @e[type=minecraft:zombie,tag=kitpvp.earth_jupiter,distance=..3,sort=nearest,limit=1] 100 minecraft:generic
tellraw @s [{"text":"[木星自测] 已召唤并打死，应看到雷；没雷先跑 "},{"text":"/function kitpvp:debug/selfcheck","color":"aqua"},{"text":" 确认存档里的包是最新的"}]
