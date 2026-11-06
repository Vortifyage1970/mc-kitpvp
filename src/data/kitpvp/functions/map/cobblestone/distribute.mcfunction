# 随机起始出生点 #cur ∈ 1..7，再由 pass 环绕分配：#cur, #cur+1, ... 环一圈。
# 7 个点都有机会被用到，且同一局不重复；人数不足时占用的是一段随机的环。
scoreboard players set #cur kitpvp.tmp 0
execute if score #cur kitpvp.tmp matches 0 if predicate kitpvp:random/1in7 run scoreboard players set #cur kitpvp.tmp 1
execute if score #cur kitpvp.tmp matches 0 if predicate kitpvp:random/1in6 run scoreboard players set #cur kitpvp.tmp 2
execute if score #cur kitpvp.tmp matches 0 if predicate kitpvp:random/1in5 run scoreboard players set #cur kitpvp.tmp 3
execute if score #cur kitpvp.tmp matches 0 if predicate kitpvp:random/1in4 run scoreboard players set #cur kitpvp.tmp 4
execute if score #cur kitpvp.tmp matches 0 if predicate kitpvp:random/1in3 run scoreboard players set #cur kitpvp.tmp 5
execute if score #cur kitpvp.tmp matches 0 if predicate kitpvp:random/1in2 run scoreboard players set #cur kitpvp.tmp 6
execute if score #cur kitpvp.tmp matches 0 run scoreboard players set #cur kitpvp.tmp 7

# 最多 1 轮就分完，写 3 轮保险
function kitpvp:map/cobblestone/pass
function kitpvp:map/cobblestone/pass
function kitpvp:map/cobblestone/pass

# 兜底：参战人数 > 7（正常不发生）时剩下的堆到出生点 1
execute as @a[tag=kitpvp.selected,tag=!kitpvp.spawn_assigned,tag=!kitpvp.spectator] run function kitpvp:map/cobblestone/spawn_1
