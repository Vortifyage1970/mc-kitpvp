# 以执行位置为球心铺一颗半径 3 的水球，球心取脚下 +1（覆盖脚到头）。
# 形状 = "欧氏距离 ≤ 3" 的那 123 个方块，按水平切片逐层铺（fill 只能填长方体，故每层拆成矩形 + 长条）：
#   球心 +3 层 1 格；+2 层 3x5 加两侧 1x3；+1 层 5x5；中心层 5x5 加十字两条 7 格；下方三层镜像
# replace air：只把空气换成水，已有方块（地形 / 别人的水）一概不动 —— 这就是"不破坏方块"。
fill ~ ~4 ~ ~ ~4 ~ minecraft:water replace air
fill ~-1 ~3 ~-2 ~1 ~3 ~2 minecraft:water replace air
fill ~-2 ~3 ~-1 ~-2 ~3 ~1 minecraft:water replace air
fill ~2 ~3 ~-1 ~2 ~3 ~1 minecraft:water replace air
fill ~-2 ~2 ~-2 ~2 ~2 ~2 minecraft:water replace air
fill ~-2 ~1 ~-2 ~2 ~1 ~2 minecraft:water replace air
fill ~-3 ~1 ~ ~3 ~1 ~ minecraft:water replace air
fill ~ ~1 ~-3 ~ ~1 ~3 minecraft:water replace air
fill ~-2 ~ ~-2 ~2 ~ ~2 minecraft:water replace air
fill ~-1 ~-1 ~-2 ~1 ~-1 ~2 minecraft:water replace air
fill ~-2 ~-1 ~-1 ~-2 ~-1 ~1 minecraft:water replace air
fill ~2 ~-1 ~-1 ~2 ~-1 ~1 minecraft:water replace air
fill ~ ~-2 ~ ~ ~-2 ~ minecraft:water replace air

# 注意：fill 出来的是水源方块，水会顺着空处向外流（半径 3 的球外溢范围更大），本包不额外封边（见 04 §五）
particle minecraft:splash ~ ~1 ~ 2.6 2.6 2.6 0.1 300

# 落地重音效（比报幕那几发重得多）：爆炸声 + 三叉戟惊雷两层叠加。
# 声源在球心（施术者最远 10 格也听得见），播给"自己 + 受影响的人"——
# 受影响 = 球心 8 格内的玩家；用 cang_release 同刻挂着的临时 tag 把自己摘掉，免得自己听两遍
playsound minecraft:entity.generic.explode master @s ~ ~ ~ 2.0 0.8
playsound minecraft:item.trident.thunder master @s ~ ~ ~ 2.0 0.9
execute as @a[distance=..8,tag=!kitpvp.tainted_fisher_self] run playsound minecraft:entity.generic.explode master @s ~ ~ ~ 2.0 0.8
execute as @a[distance=..8,tag=!kitpvp.tainted_fisher_self] run playsound minecraft:item.trident.thunder master @s ~ ~ ~ 2.0 0.9
