# 提示写在这里：refill1 每刻都被调到，写那边会变成每刻刷屏
function kitpvp:skill/tainted_tamer/give1
title @s actionbar {"text":"召唤蛋已补充","color":"dark_red"}
playsound minecraft:entity.item.pickup master @s ~ ~ ~ 0.6 1.3
