# ===== 从已注册地图中随机选一张（均匀 4 选 1） =====
# 已注册：沙漠（id=1）、竞技场（id=2）、地球（id=7）、西安（id=8）
# 逐级 1/n 判定，结果均匀。

scoreboard players set #global kitpvp.map 0
execute if score #global kitpvp.map matches 0 if predicate kitpvp:random/1in4 run scoreboard players set #global kitpvp.map 1
execute if score #global kitpvp.map matches 0 if predicate kitpvp:random/1in3 run scoreboard players set #global kitpvp.map 2
execute if score #global kitpvp.map matches 0 if predicate kitpvp:random/1in2 run scoreboard players set #global kitpvp.map 7
execute if score #global kitpvp.map matches 0 run scoreboard players set #global kitpvp.map 8
