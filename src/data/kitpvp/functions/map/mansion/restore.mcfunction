# 豪宅：两块模板沿 z 拼（起点 6651 60 -46 / 6651 61 2）。
# 模板只存方块（导出时关掉「包含实体」）；复原 = 先按区域清掉**所有实体**，再 place 方块，
# 最后用 summon 一条条把画 / 盔甲架 / 船 / 矿车摆回来（见 map/mansion/decor 与 04 §七.3）
kill @e[x=6651,y=60,z=-46,dx=96,dy=96,dz=96]
place template kitpvp:mansion1 6651 60 -46
place template kitpvp:mansion2 6651 61 2
function kitpvp:map/mansion/decor
