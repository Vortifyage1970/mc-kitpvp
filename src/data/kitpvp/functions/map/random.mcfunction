# ===== 从已注册地图中随机选一张（均匀） =====
# 已注册：沙漠（id=1）、竞技场（id=2）、地球（id=7）、西安（id=8）
# 结果写入 #global kitpvp.map。
#
# 地图 id 不连续，所以分两步：
#   ① 用二进制随机数得到 0..(池大小-1) 的均匀索引
#   ② 把索引映射到真实 id
#
# 随机数生成：1.20.1 没有 /random 命令。
#   用 predicate kitpvp:random/1in2（chance 0.5）连掷 N 次，拼出 0..2^N-1。
#   地图数是 4，2 位即够；每翻一倍补一行 1in2，不会出现 1in100.json 那种爆炸。
#   ⚠ 前提：同一 tick 内多次评估同一 predicate 必须是独立掷骰（未实测，见文末）。
#
# 池大小每加一张地图改一次，并在文末映射表按同格式追加一行。

# 池大小 = 当前已注册地图数
scoreboard players set #pool_size kitpvp.game 4

# 掷 2 位二进制，得到 0..3
scoreboard players set #rng kitpvp.game 0
execute if predicate kitpvp:random/1in2 run scoreboard players add #rng kitpvp.game 1
execute if predicate kitpvp:random/1in2 run scoreboard players add #rng kitpvp.game 2

# 取模到 [0, 池大小)
scoreboard players operation #rng kitpvp.game %= #pool_size kitpvp.game

# 索引 → 地图 id（新增地图时按同格式追加一行）
execute if score #rng kitpvp.game matches 0 run scoreboard players set #global kitpvp.map 1
execute if score #rng kitpvp.game matches 1 run scoreboard players set #global kitpvp.map 2
execute if score #rng kitpvp.game matches 2 run scoreboard players set #global kitpvp.map 7
execute if score #rng kitpvp.game matches 3 run scoreboard players set #global kitpvp.map 8
