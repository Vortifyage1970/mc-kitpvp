# 单独验"雷本身能不能出来"：/function kitpvp:debug/jupiter_bolt
# 在脚下直接召唤一道雷（不走 tick、不看血量）——如果这道也看不见，问题在客户端/维度，不在木星逻辑
summon minecraft:lightning_bolt ~ ~ ~
tellraw @s [{"text":"[木星自测] 已在脚下召唤一道雷；看不见 = 雷本身出不来，与木星逻辑无关","color":"gray"}]
