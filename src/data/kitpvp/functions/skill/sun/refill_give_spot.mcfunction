# 提示写在这里：refill_spot 每刻都被调到，写那边会变成每刻刷屏
function kitpvp:skill/sun/give_spot
title @s actionbar {"text":"太阳黑子已就绪","color":"dark_purple"}
playsound minecraft:entity.item.pickup master @s ~ ~ ~ 0.6 1.1
