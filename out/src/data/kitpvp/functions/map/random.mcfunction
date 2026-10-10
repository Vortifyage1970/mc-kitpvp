# ===== 从已注册地图中随机选一张 =====
# 已注册：沙漠（id=1）、竞技场（id=2）、地球（id=7）
# 三张图等概率（各 1/3）：先默认 1；
#   1/3 概率切到 2；未切成功时（仍为 1）再 1/2 概率切到 7。
# 新增第四张图时继续套娃：再加一条 1in4 的判定放在最前，后面顺延。

scoreboard players set #global kitpvp.map 1
execute if predicate kitpvp:random/1in3 run scoreboard players set #global kitpvp.map 2
execute if score #global kitpvp.map matches 1 if predicate kitpvp:random/1in2 run scoreboard players set #global kitpvp.map 7
