# @s = 刚倒下的木星本体（尸体还在，Health 已经归零）
# 先劈雷再打标记：尸体在动画结束前每刻都会被 tick 扫到，不打标记就会连着劈一串
summon minecraft:lightning_bolt ~ ~ ~
tag @s add kitpvp.earth_jupiter_struck
