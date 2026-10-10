# ===== 将玩家随机分布到当前地图的出生点 =====
# 调用方：game/start_impl
# 依赖：#global kitpvp.map 指向当前地图（0 = 未选，1 = 沙漠，2 = 竞技场，7 = 地球）
# 新增地图时按 [ 沙漠 ] 的格式复制一行

# 1. 清掉所有参战玩家的"已分配"标记
tag @a[tag=kitpvp.selected] remove kitpvp.spawn_assigned

# 2. 按地图 id 分发
execute if score #global kitpvp.map matches 1 run function kitpvp:map/desert/distribute
execute if score #global kitpvp.map matches 2 run function kitpvp:map/arena/distribute
execute if score #global kitpvp.map matches 7 run function kitpvp:map/earth/distribute
