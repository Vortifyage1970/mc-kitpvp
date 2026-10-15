# 以执行位置为球心铺直径 3 的水球（球心 = 脚下 +1）：19 格，即"欧氏距离 ≤ 1.5"的方块
# replace air：只把空气换成水，不动已有方块
fill ~-1 ~1 ~-1 ~1 ~1 ~1 minecraft:water replace air
fill ~ ~2 ~-1 ~ ~2 ~1 minecraft:water replace air
fill ~-1 ~2 ~ ~1 ~2 ~ minecraft:water replace air
fill ~ ~ ~-1 ~ ~ ~1 minecraft:water replace air
fill ~-1 ~ ~ ~1 ~ ~ minecraft:water replace air

# 水源会顺着空处向外流，本包不封边（见 04 §五）
particle minecraft:splash ~ ~1 ~ 1.2 1.2 1.2 0.1 150

# 落地重音效（比报幕重得多）：播给自己与球心 8 格内的玩家，临时 tag 把自己摘掉
playsound minecraft:entity.generic.explode master @s ~ ~ ~ 2.0 0.8
playsound minecraft:item.trident.thunder master @s ~ ~ ~ 2.0 0.9
execute as @a[distance=..8,tag=!kitpvp.tainted_fisher_self] run playsound minecraft:entity.generic.explode master @s ~ ~ ~ 2.0 0.8
execute as @a[distance=..8,tag=!kitpvp.tainted_fisher_self] run playsound minecraft:item.trident.thunder master @s ~ ~ ~ 2.0 0.9
