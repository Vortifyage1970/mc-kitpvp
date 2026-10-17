# 提示写在这里：refill_flare 每刻都被调到，写那边会变成每刻刷屏
function kitpvp:skill/sun/give_flare
title @s actionbar {"text":"太阳耀斑已就绪","color":"gold"}
playsound minecraft:entity.item.pickup master @s ~ ~ ~ 0.6 1.3
