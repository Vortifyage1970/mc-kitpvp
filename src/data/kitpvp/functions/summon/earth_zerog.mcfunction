# 地球·40 无重力僵尸（临时试验品，测完可以直接删）
# 删除方法：删掉本文件 + random.mcfunction 里 matches 39 那一行，再把 #pool_size 从 40 改回 39
# NoGravity:1b 只关重力：它照样追人、砍人，只是会飘在原高度上，走出悬崖也不掉下去
# Silent:1b 免得僵尸的呻吟一路响；PersistenceRequired:1b 不会因为跑远被清掉
summon minecraft:zombie ~ ~ ~ {Tags:["kitpvp.earth_minion","kitpvp.earth_minion_new","kitpvp.earth_zerog"],CustomName:'{"text":"无重力僵尸","color":"aqua"}',CustomNameVisible:1b,PersistenceRequired:1b,CanPickUpLoot:0b,Silent:1b,NoGravity:1b}
