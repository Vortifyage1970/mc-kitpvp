# ===== 沙漠出生点：一轮顺序扫描 =====
# 按 1..9 顺序检查：编号等于当前游标 #cur 的出生点，才去领一个玩家。
# @r 集合为空时该行整条命令不执行，游标也不会前进 —— 这正是我们要的
# （人分完了自然就空转）。
# 由 kitpvp:map/desert/distribute 反复调用。

execute if score #cur kitpvp.tmp matches 1 as @r[tag=kitpvp.selected,tag=!kitpvp.spawn_assigned,tag=!kitpvp.spectator] run function kitpvp:map/desert/spawn_1
execute if score #cur kitpvp.tmp matches 2 as @r[tag=kitpvp.selected,tag=!kitpvp.spawn_assigned,tag=!kitpvp.spectator] run function kitpvp:map/desert/spawn_2
execute if score #cur kitpvp.tmp matches 3 as @r[tag=kitpvp.selected,tag=!kitpvp.spawn_assigned,tag=!kitpvp.spectator] run function kitpvp:map/desert/spawn_3
execute if score #cur kitpvp.tmp matches 4 as @r[tag=kitpvp.selected,tag=!kitpvp.spawn_assigned,tag=!kitpvp.spectator] run function kitpvp:map/desert/spawn_4
execute if score #cur kitpvp.tmp matches 5 as @r[tag=kitpvp.selected,tag=!kitpvp.spawn_assigned,tag=!kitpvp.spectator] run function kitpvp:map/desert/spawn_5
execute if score #cur kitpvp.tmp matches 6 as @r[tag=kitpvp.selected,tag=!kitpvp.spawn_assigned,tag=!kitpvp.spectator] run function kitpvp:map/desert/spawn_6
execute if score #cur kitpvp.tmp matches 7 as @r[tag=kitpvp.selected,tag=!kitpvp.spawn_assigned,tag=!kitpvp.spectator] run function kitpvp:map/desert/spawn_7
execute if score #cur kitpvp.tmp matches 8 as @r[tag=kitpvp.selected,tag=!kitpvp.spawn_assigned,tag=!kitpvp.spectator] run function kitpvp:map/desert/spawn_8
execute if score #cur kitpvp.tmp matches 9 as @r[tag=kitpvp.selected,tag=!kitpvp.spawn_assigned,tag=!kitpvp.spectator] run function kitpvp:map/desert/spawn_9
