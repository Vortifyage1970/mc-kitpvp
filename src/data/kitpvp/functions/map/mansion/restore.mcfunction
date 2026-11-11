# 豪宅：三块 48³ 模板拼成（6651 60 -46 / 6651 61 2 / 6621 61 -47，第三块是后加的西翼）。
# 模板只存方块（导出时关掉「包含实体」）；复原 = 先按区域清掉**所有实体**，再 place 方块，
# 最后用 summon 一条条把画 / 盔甲架 / 船 / 矿车摆回来（见 map/mansion/decor 与 04 §七.3）
kill @e[x=6621,y=60,z=-47,dx=127,dy=96,dz=98]
# ⚠ 顺序有意义：mansion3（西翼）和 mansion1 在 x 6651..6668 上重叠 18 格，两块在重叠区**内容不同**。
#   实测世界在重叠区与 mansion1 完全一致、与 mansion3 不一致 ⇒ 必须**先放 mansion3 再放 mansion1**，
#   让 mansion1 覆盖重叠区；反过来会把 mansion1 的部分房间刷成西翼的旧内容。
place template kitpvp:mansion3 6621 61 -47
place template kitpvp:mansion1 6651 60 -46
place template kitpvp:mansion2 6651 61 2
function kitpvp:map/mansion/decor
