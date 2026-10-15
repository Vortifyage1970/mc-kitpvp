# 以执行位置为球心铺一颗直径 3 的水球（球心取脚下 +1，覆盖脚到头）。
# 形状 = "欧氏距离 ≤ 1.5" 的那 19 个方块：中间一层 3x3，上下各一个十字（5 格），三个方向都是 3 格宽。
# replace air：只把空气换成水，已有方块（地形 / 别人的水）一概不动 —— 这就是"不破坏方块"。
fill ~-1 ~1 ~-1 ~1 ~1 ~1 minecraft:water replace air
fill ~ ~2 ~-1 ~ ~2 ~1 minecraft:water replace air
fill ~-1 ~2 ~ ~1 ~2 ~ minecraft:water replace air
fill ~ ~ ~-1 ~ ~ ~1 minecraft:water replace air
fill ~-1 ~ ~ ~1 ~ ~ minecraft:water replace air

# 注意：fill 出来的是水源方块，水会顺着空处向外流（最外圈仍能外溢约 7 格），本包不额外封边（见 04 §五）
particle minecraft:splash ~ ~1 ~ 1.2 1.2 1.2 0.1 150

# 落地重音效（比报幕那几发重得多）：爆炸声 + 三叉戟惊雷两层叠加。
# 声源在球心（施术者最远 10 格也听得见），播给"自己 + 受影响的人"——
# 受影响 = 球心 8 格内的玩家；用 cang_release 同刻挂着的临时 tag 把自己摘掉，免得自己听两遍
playsound minecraft:entity.generic.explode master @s ~ ~ ~ 2.0 0.8
playsound minecraft:item.trident.thunder master @s ~ ~ ~ 2.0 0.9
execute as @a[distance=..8,tag=!kitpvp.tainted_fisher_self] run playsound minecraft:entity.generic.explode master @s ~ ~ ~ 2.0 0.8
execute as @a[distance=..8,tag=!kitpvp.tainted_fisher_self] run playsound minecraft:item.trident.thunder master @s ~ ~ ~ 2.0 0.9
