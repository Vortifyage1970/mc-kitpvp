# 随机起始出生点 #cur ∈ 1..8，再由 pass 环绕分配（8 个点都有机会，同一局不重复）
scoreboard players set #cur kitpvp.tmp 0
execute if score #cur kitpvp.tmp matches 0 if predicate kitpvp:random/1in8 run scoreboard players set #cur kitpvp.tmp 1
execute if score #cur kitpvp.tmp matches 0 if predicate kitpvp:random/1in7 run scoreboard players set #cur kitpvp.tmp 2
execute if score #cur kitpvp.tmp matches 0 if predicate kitpvp:random/1in6 run scoreboard players set #cur kitpvp.tmp 3
execute if score #cur kitpvp.tmp matches 0 if predicate kitpvp:random/1in5 run scoreboard players set #cur kitpvp.tmp 4
execute if score #cur kitpvp.tmp matches 0 if predicate kitpvp:random/1in4 run scoreboard players set #cur kitpvp.tmp 5
execute if score #cur kitpvp.tmp matches 0 if predicate kitpvp:random/1in3 run scoreboard players set #cur kitpvp.tmp 6
execute if score #cur kitpvp.tmp matches 0 if predicate kitpvp:random/1in2 run scoreboard players set #cur kitpvp.tmp 7
execute if score #cur kitpvp.tmp matches 0 run scoreboard players set #cur kitpvp.tmp 8

function kitpvp:map/ocean/pass
function kitpvp:map/ocean/pass
function kitpvp:map/ocean/pass

# 兜底：参战人数 > 8（正常不发生）时剩下的堆到出生点 1
execute as @a[tag=kitpvp.selected,tag=!kitpvp.spawn_assigned,tag=!kitpvp.spectator] run function kitpvp:map/ocean/spawn_1
