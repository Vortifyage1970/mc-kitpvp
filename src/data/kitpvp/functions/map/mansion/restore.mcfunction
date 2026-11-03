# place template <template> [pos] [rotation] [mirror] [integrity] [seed]
# 这栋豪宅的模板里带装饰实体（盔甲架 / 船 / 矿车），画已经被剥出去了（见最后一行）：
# 全部按区域先清再放，否则每局叠一层、位置越看越乱（见 04 §七 第 4、5 条）
kill @e[tag=kitpvp.displayitem,x=6651,y=60,z=-46,dx=96,dy=96,dz=96]
kill @e[type=minecraft:painting,x=6651,y=60,z=-46,dx=96,dy=96,dz=96]
kill @e[type=minecraft:boat,x=6651,y=60,z=-46,dx=96,dy=96,dz=96]
kill @e[type=minecraft:minecart,x=6651,y=60,z=-46,dx=96,dy=96,dz=96]

place template kitpvp:mansion1 6651 60 -46
place template kitpvp:mansion2 6651 61 2

# 画不在模板里：按绝对 Tile 坐标逐幅重建（模板里的画锚点存的是导出时的绝对值，放别处会整体错位）
function kitpvp:map/mansion/paintings
