# @s = 刚倒下的木星本体（尸体还在，Health 已经归零）
# 先劈雷再打标记：尸体在动画结束前每刻都会被 tick 扫到，不打标记就会连着劈一串
# 下面第一行是排查用的提示（一局最多出现几次，不影响手感）；嫌吵删掉即可
tellraw @a [{"text":"[木星] 抓到死亡帧，hp=","color":"gray"},{"score":{"name":"@s","objective":"kitpvp.earth_hp"}},{"text":" → 劈雷","color":"gray"}]
summon minecraft:lightning_bolt ~ ~ ~
tag @s add kitpvp.earth_jupiter_struck
