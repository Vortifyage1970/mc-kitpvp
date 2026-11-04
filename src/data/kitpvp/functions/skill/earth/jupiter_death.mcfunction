# @s = 木星背上的隐形锚点：木星本体已经消失，锚点停在它倒下的那个位置
# 先劈雷再删自己：锚点每刻都会被 tick 扫一遍，留着不动就会顺着同一点连劈
summon minecraft:lightning_bolt ~ ~ ~
kill @s
