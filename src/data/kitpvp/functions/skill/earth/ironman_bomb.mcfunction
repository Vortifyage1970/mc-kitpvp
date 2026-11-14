# @s = 铁人，at 它身上：丢一颗"小炸弹" —— 直接复用炸弹兵的代码（summon/bomber_small.mcfunction:2）
# 原版苦力怕真爆炸：Fuse:0 立爆、ExplosionRadius:1（半径 1；mobGriefing 关时不破坏地形）
# 铁人自己站在爆点上，靠全套爆炸保护 V 扛住（这是给铁人配附魔的原因）
summon minecraft:creeper ~ ~1 ~ {Tags:["kitpvp.bomb","kitpvp.bomb_small"],CustomName:'{"text":"小炸弹","color":"gold"}',CustomNameVisible:1b,ignited:1b,Fuse:0s,ExplosionRadius:1b}
