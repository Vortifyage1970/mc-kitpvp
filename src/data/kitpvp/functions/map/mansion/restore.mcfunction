# place template <template> [pos] [rotation] [mirror] [integrity] [seed]
kill @e[tag=kitpvp.displayitem,x=6651,y=60,z=-46,dx=96,dy=96,dz=96]
# 画没有 tag，只能按类型 + 区域清：模板里的画存的是**导出时的绝对方块坐标**（TileX/TileY/TileZ），
# 每局复原有旧画残留就会新旧叠着看，位置全部对不上（见 04 §七 第 5 条）
kill @e[type=minecraft:painting,x=6651,y=60,z=-46,dx=96,dy=96,dz=96]
place template kitpvp:mansion1 6651 60 -46
place template kitpvp:mansion2 6651 61 2
