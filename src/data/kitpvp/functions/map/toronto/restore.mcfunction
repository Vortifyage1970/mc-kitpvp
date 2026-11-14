# 多伦多：3×3 张 48³ 模板拼成现代都市（矿车交通）
# 模板只存方块（导出时关掉「包含实体」）；复原 = 先按并集清实体，再 place 方块
# 潜影盒里的东西跟着方块走；按钮/矿车由 map/toronto/cart_* 现填
kill @e[x=5940,y=60,z=5942,dx=144,dy=96,dz=144]
place template kitpvp:toronto1 5940 60 5942
place template kitpvp:toronto2 5940 60 5990
place template kitpvp:toronto3 5940 60 6038
place template kitpvp:toronto4 5988 60 5942
place template kitpvp:toronto5 5988 60 5990
place template kitpvp:toronto6 5988 60 6038
place template kitpvp:toronto7 6036 60 5942
# place template kitpvp:toronto8 6036 60 5990   # ← 缺文件，等存档补 toronto8.nbt
place template kitpvp:toronto9 6036 60 6038
