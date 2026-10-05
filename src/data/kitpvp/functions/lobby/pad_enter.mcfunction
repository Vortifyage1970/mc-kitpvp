# ===== 主大厅：压力板 → 职业介绍分流 =====
# 由 lobby/pad 调用，@s = 刚踩上板的玩家
#
# 新增一块职业压力板时：
#   1) 在大厅铺一块 minecraft:light_weighted_pressure_plate
#   2) 把该方块的 x/y/z 填进下面新增的选择器（dx/dy/dz 固定填 1）
#
# 选择器体积口径：
#   x/y/z 是压力板方块自身的坐标，dx=dy=dz=1 覆盖 1×1×1 的立方体。
#   玩家站在板上时脚部 Y = 方块 Y + 0.0625，落在 [y, y+1) 内，会被匹配。
#   若板下是方块、板上再叠高（多层板），需要相应加大 dy。
#
# ⚠ 下面的坐标全部是占位符，必须换成实际的大厅坐标；
#   若两块板填了相同坐标，会同时弹出多个职业描述。

tag @s add kitpvp.on_pad

# --- 战士 ---
execute if entity @s[x=-226,y=71,z=98,dx=1,dy=1,dz=1] run function kitpvp:kit/info/warrior

# --- 弓箭手 ---
execute if entity @s[x=-230,y=71,z=98,dx=1,dy=1,dz=1] run function kitpvp:kit/info/archer

# --- 坦克 ---
execute if entity @s[x=-234,y=71,z=98,dx=1,dy=1,dz=1] run function kitpvp:kit/info/tank

# --- 刺客 ---
execute if entity @s[x=-238,y=71,z=98,dx=1,dy=1,dz=1] run function kitpvp:kit/info/assassin

# --- 纵火狂 ---
execute if entity @s[x=-242,y=71,z=98,dx=1,dy=1,dz=1] run function kitpvp:kit/info/arsonist

# …… 新增职业时按同格式追加