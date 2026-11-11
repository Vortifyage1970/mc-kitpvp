# @s = 井盖（埋在地底 2 格的那只僵尸）：有人站到头顶就破土而出
# 先摘标签：这一套只炸一次，之后它就是一只普通的、会走会打的僵尸
tag @s remove kitpvp.earth_manhole

# 从地底顶到地面（原地 +2 格），并解除无敌与 NoAI：破土之后就能被正常打死、也会主动追人
tp @s ~ ~2 ~
data merge entity @s {Invulnerable:0b,NoAI:0b}

# 破土的效果：4 格内玩家缓慢 III 6 秒（踩到井盖就是被拖住）
# ★ 召唤者本人不吃这一下：mh_summoner=1 是召唤当刻打的记号（手动 /function 召的也有）
execute as @a[distance=..4,gamemode=!spectator,tag=!kitpvp.spectator,nbt=!{Health:0.0f}] unless score @s kitpvp.mh_summoner matches 1 at @s run effect give @s minecraft:slowness 6 2 true

# 音画：沙砾炸开 + 泥土翻起 + 一圈碎屑，隔墙也听得见
playsound minecraft:block.gravel.break master @a[distance=..24] ~ ~ ~ 1.0 0.9
playsound minecraft:block.rooted_dirt.break master @a[distance=..24] ~ ~ ~ 0.9 0.7
particle minecraft:block minecraft:gravel ~ ~0.2 ~ 1.2 0.4 1.2 0.15 40
particle minecraft:poof ~ ~0.6 ~ 1 0.4 1 0.05 12
