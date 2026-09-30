# ===== 从已注册地图中随机选一张 =====
# 当前只有沙漠（id=1），直接选它。
# 新增地图时，改为「用 predicate random_chance 按概率掷骰」或「用入参索引」，
# 并把 id 保持连续（0 = 未选，1..N = 已注册地图）。

scoreboard players set #global kitpvp.map 1