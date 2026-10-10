# ===== 复原当前地图 =====
# 调用方：game/reset 第四步
# 依赖：#global kitpvp.map 指向当前地图（0 = 未选，1 = 沙漠，7 = 地球）
# 具体复原细节写在各图自己的 kitpvp:map/<地图名>/restore

execute if score #global kitpvp.map matches 1 run function kitpvp:map/desert/restore
execute if score #global kitpvp.map matches 7 run function kitpvp:map/earth/restore
