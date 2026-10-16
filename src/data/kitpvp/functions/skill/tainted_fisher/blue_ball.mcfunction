# 以执行位置为球心铺半径 1 的水球（球心 = 脚下 +1）：7 格，即"欧氏距离 ≤ 1"的方块
# 三条轴线相交 = 中心 + 六个轴向邻居
# replace air：只把空气换成水，不动已有方块
fill ~ ~ ~ ~ ~2 ~ minecraft:water replace air
fill ~-1 ~1 ~ ~1 ~1 ~ minecraft:water replace air
fill ~ ~1 ~-1 ~ ~1 ~1 minecraft:water replace air

# 水源会顺着空处向外流，本包不封边（见 04 §五）
particle minecraft:splash ~ ~1 ~ 0.9 0.9 0.9 0.05 80

# 落地重音效（比报幕重得多）：播给自己与球心 8 格内的玩家，临时 tag 把自己摘掉
playsound minecraft:entity.generic.explode master @s ~ ~ ~ 2.0 0.8
playsound minecraft:item.trident.thunder master @s ~ ~ ~ 2.0 0.9
execute as @a[distance=..8,tag=!kitpvp.tainted_fisher_self] run playsound minecraft:entity.generic.explode master @s ~ ~ ~ 2.0 0.8
execute as @a[distance=..8,tag=!kitpvp.tainted_fisher_self] run playsound minecraft:item.trident.thunder master @s ~ ~ ~ 2.0 0.9
