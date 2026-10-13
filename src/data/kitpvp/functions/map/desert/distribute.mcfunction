# 随机起始出生点 #cur ∈ 1..9，再由 pass 环绕分配：#cur, #cur+1, ... 环一圈。
# 9 个点都有机会被用到，且同一局不重复；人数不足时占用的是一段随机的环。
# 依赖 objective kitpvp.tmp（load 中创建）
tag @a[tag=kitpvp.selected] remove kitpvp.spawn_assigned

scoreboard players set #cur kitpvp.tmp 0
execute if score #cur kitpvp.tmp matches 0 if predicate kitpvp:random/1in9 run scoreboard players set #cur kitpvp.tmp 1
execute if score #cur kitpvp.tmp matches 0 if predicate kitpvp:random/1in8 run scoreboard players set #cur kitpvp.tmp 2
execute if score #cur kitpvp.tmp matches 0 if predicate kitpvp:random/1in7 run scoreboard players set #cur kitpvp.tmp 3
execute if score #cur kitpvp.tmp matches 0 if predicate kitpvp:random/1in6 run scoreboard players set #cur kitpvp.tmp 4
execute if score #cur kitpvp.tmp matches 0 if predicate kitpvp:random/1in5 run scoreboard players set #cur kitpvp.tmp 5
execute if score #cur kitpvp.tmp matches 0 if predicate kitpvp:random/1in4 run scoreboard players set #cur kitpvp.tmp 6
execute if score #cur kitpvp.tmp matches 0 if predicate kitpvp:random/1in3 run scoreboard players set #cur kitpvp.tmp 7
execute if score #cur kitpvp.tmp matches 0 if predicate kitpvp:random/1in2 run scoreboard players set #cur kitpvp.tmp 8
execute if score #cur kitpvp.tmp matches 0 run scoreboard players set #cur kitpvp.tmp 9

# 最多 2 轮分完，写 3 轮保险
function kitpvp:map/desert/pass
function kitpvp:map/desert/pass
function kitpvp:map/desert/pass

# 兜底：参战人数 > 9（正常不发生）时剩下的堆到出生点 1
execute as @a[tag=kitpvp.selected,tag=!kitpvp.spawn_assigned,tag=!kitpvp.spectator] run function kitpvp:map/desert/spawn_1
