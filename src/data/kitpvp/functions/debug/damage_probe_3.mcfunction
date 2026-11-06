tellraw @a [{"text":"[测试 3/3] mob_attack + by 深池僵尸 2 点（就是 dublinn_strike 用的写法）","color":"gold"}]
execute as @a at @s run damage @s 2 minecraft:mob_attack by @e[tag=kitpvp.earth_dublinn_zombie,distance=..6,limit=1,sort=nearest]
tellraw @a [{"text":"[测试结束] 三段里哪几段掉了 2 点血，就告诉我们那个写法有效","color":"dark_gray"}]
