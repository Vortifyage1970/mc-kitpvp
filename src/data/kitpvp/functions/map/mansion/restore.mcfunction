# 豪宅：三块 48³ 模板拼成（6651 60 -46 / 6651 61 2 / 6621 61 -47，第三块是后加的西翼）。
# 模板只存方块（导出时关掉「包含实体」）；复原 = 先按区域清掉**所有实体**，再 place 方块，
# 最后用 summon 一条条把画 / 盔甲架 / 船 / 矿车摆回来（见 map/mansion/decor 与 04 §七.3）
kill @e[x=6621,y=60,z=-47,dx=127,dy=96,dz=98]
place template kitpvp:mansion1 6651 60 -46
place template kitpvp:mansion2 6651 61 2
place template kitpvp:mansion3 6621 61 -47
function kitpvp:map/mansion/decor
