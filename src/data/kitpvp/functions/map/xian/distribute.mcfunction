# ===== 西安地图：把参战玩家随机分到 6 个出生点 =====
# 思路同地球：随机一个「起始出生点」#cur ∈ 1..6，
#       再反复遍历 1..6 环绕分配，保证 6 个点都有机会被用到，
#       同一局内一个出生点不会被分配两次。
#
# 依赖：objective kitpvp.tmp（在 load.mcfunction 中创建）
# 调用方：kitpvp:map/distribute

# --- 1. 清掉上一局的分配标记 ---
tag @a[tag=kitpvp.selected] remove kitpvp.spawn_assigned

# --- 2. 随机起始出生点 #cur ∈ 1..6（逐级 1/n 判定，结果均匀） ---
scoreboard players set #cur kitpvp.tmp 0
execute if score #cur kitpvp.tmp matches 0 if predicate kitpvp:random/1in6 run scoreboard players set #cur kitpvp.tmp 1
execute if score #cur kitpvp.tmp matches 0 if predicate kitpvp:random/1in5 run scoreboard players set #cur kitpvp.tmp 2
execute if score #cur kitpvp.tmp matches 0 if predicate kitpvp:random/1in4 run scoreboard players set #cur kitpvp.tmp 3
execute if score #cur kitpvp.tmp matches 0 if predicate kitpvp:random/1in3 run scoreboard players set #cur kitpvp.tmp 4
execute if score #cur kitpvp.tmp matches 0 if predicate kitpvp:random/1in2 run scoreboard players set #cur kitpvp.tmp 5
execute if score #cur kitpvp.tmp matches 0 run scoreboard players set #cur kitpvp.tmp 6

# --- 3. 反复扫描，直到所有人都有落点（6 个点、最多 6 人，两轮足够，写三轮保险） ---
function kitpvp:map/xian/pass
function kitpvp:map/xian/pass
function kitpvp:map/xian/pass

# --- 4. 兜底：参战人数 > 6 时（正常不会发生），剩下的堆到出生点 1 ---
execute as @a[tag=kitpvp.selected,tag=!kitpvp.spawn_assigned,tag=!kitpvp.spectator] run function kitpvp:map/xian/spawn_1
