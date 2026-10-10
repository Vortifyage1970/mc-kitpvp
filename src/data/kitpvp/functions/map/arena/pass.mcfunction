# ===== 竞技场出生点：一轮顺序扫描 =====
# 与沙漠/地球 pass 同构。按 1..9 顺序检查，编号等于当前游标 #cur 的出生点才领玩家。
# @r 集合为空时该行整条命令不执行，游标也不会前进 —— 这正是我们要的。
# 由 kitpvp:map/arena/distribute 反复调用。

execute if score #cur kitpvp.tmp matches 1 as @r[tag=kitpvp.selected,tag=!kitpvp.spawn_assigned,tag=!kitpvp.spectator] run function kitpvp:map/arena/spawn_1
execute if score #cur kitpvp.tmp matches 2 as @r[tag=kitpvp.selected,tag=!kitpvp.spawn_assigned,tag=!kitpvp.spectator] run function kitpvp:map/arena/spawn_2
execute if score #cur kitpvp.tmp matches 3 as @r[tag=kitpvp.selected,tag=!kitpvp.spawn_assigned,tag=!kitpvp.spectator] run function kitpvp:map/arena/spawn_3
execute if score #cur kitpvp.tmp matches 4 as @r[tag=kitpvp.selected,tag=!kitpvp.spawn_assigned,tag=!kitpvp.spectator] run function kitpvp:map/arena/spawn_4
execute if score #cur kitpvp.tmp matches 5 as @r[tag=kitpvp.selected,tag=!kitpvp.spawn_assigned,tag=!kitpvp.spectator] run function kitpvp:map/arena/spawn_5
execute if score #cur kitpvp.tmp matches 6 as @r[tag=kitpvp.selected,tag=!kitpvp.spawn_assigned,tag=!kitpvp.spectator] run function kitpvp:map/arena/spawn_6
execute if score #cur kitpvp.tmp matches 7 as @r[tag=kitpvp.selected,tag=!kitpvp.spawn_assigned,tag=!kitpvp.spectator] run function kitpvp:map/arena/spawn_7
execute if score #cur kitpvp.tmp matches 8 as @r[tag=kitpvp.selected,tag=!kitpvp.spawn_assigned,tag=!kitpvp.spectator] run function kitpvp:map/arena/spawn_8
execute if score #cur kitpvp.tmp matches 9 as @r[tag=kitpvp.selected,tag=!kitpvp.spawn_assigned,tag=!kitpvp.spectator] run function kitpvp:map/arena/spawn_9
