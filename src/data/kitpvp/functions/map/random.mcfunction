# ===== 从已注册地图中随机选一张 =====
# 已注册：沙漠（id=1）、地球（id=7）
# 两张图时 50/50：先默认 1，再 1/2 概率切到 7。
# 新增第三张图时改成逐级判定：1in3 未命中 → 1in2 未命中 → 最终落到第三个 id。

scoreboard players set #global kitpvp.map 1
execute if predicate kitpvp:random/1in3 run scoreboard players set #global kitpvp.map 2
execute if predicate kitpvp:random/1in2 run scoreboard players set #global kitpvp.map 7