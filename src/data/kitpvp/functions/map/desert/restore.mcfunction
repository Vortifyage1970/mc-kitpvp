# 沙漠：4 张模板 2×2 拼回整图，各自原点在 x / z 上相隔 48
# 模板只含方块（导出时关掉「包含实体」）；展示框等装饰在这张图里手动摆好，
# 打了 invulnerable + kitpvp.displayitem，所以这里**不再按区域清实体**（见 04 §七.3）
# These are all intended.
place template kitpvp:desert1 -382 72 -97
place template kitpvp:desert2 -382 72 -49
place template kitpvp:desert3 -334 73 -97
place template kitpvp:desert4 -334 72 -49
schedule function kitpvp:util/clear_item 200t
