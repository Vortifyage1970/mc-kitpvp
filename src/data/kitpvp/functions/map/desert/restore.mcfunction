# 沙漠：4 张模板 2×2 拼回整图，各自原点在 x / z 上相隔 48。
# 模板只存方块（导出时关掉「包含实体」）；复原 = 先按区域清掉**所有实体**，再 place 方块，
# 最后用 summon 一条条把展示框 / 盔甲架 / 矿车摆回来（见 map/desert/decor 与 04 §七.3）
kill @e[x=-382,y=72,z=-97,dx=96,dy=96,dz=96]
# These are all intended.
place template kitpvp:desert1 -382 72 -97
place template kitpvp:desert2 -382 72 -49
place template kitpvp:desert3 -334 73 -97
place template kitpvp:desert4 -334 72 -49
function kitpvp:map/desert/decor
