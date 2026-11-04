# @s = 木星（已经被打死、尸体还留着的那二十来刻）：在它倒下的地方劈一道雷
# 必须先打标记再劈：tick 里那两行每刻都会重跑，尸体留在世界里的每刻都会再命中一次，
# 不挡就是顺着同一具尸体连劈几十道雷
tag @s add kitpvp.earth_jupiter_struck
summon minecraft:lightning_bolt ~ ~ ~

# 尸体本身留着也没用，而且它每刻还在被 tick 扫一遍，直接清掉
kill @s
