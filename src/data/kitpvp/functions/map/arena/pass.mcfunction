# 一轮顺序扫描（1..9）：编号等于游标 #cur 的出生点领一个玩家；@r 为空则整行不执行、游标不前进
execute if score #cur kitpvp.tmp matches 1 as @r[tag=kitpvp.selected,tag=!kitpvp.spawn_assigned,tag=!kitpvp.spectator] run function kitpvp:map/arena/spawn_1
execute if score #cur kitpvp.tmp matches 2 as @r[tag=kitpvp.selected,tag=!kitpvp.spawn_assigned,tag=!kitpvp.spectator] run function kitpvp:map/arena/spawn_2
execute if score #cur kitpvp.tmp matches 3 as @r[tag=kitpvp.selected,tag=!kitpvp.spawn_assigned,tag=!kitpvp.spectator] run function kitpvp:map/arena/spawn_3
execute if score #cur kitpvp.tmp matches 4 as @r[tag=kitpvp.selected,tag=!kitpvp.spawn_assigned,tag=!kitpvp.spectator] run function kitpvp:map/arena/spawn_4
execute if score #cur kitpvp.tmp matches 5 as @r[tag=kitpvp.selected,tag=!kitpvp.spawn_assigned,tag=!kitpvp.spectator] run function kitpvp:map/arena/spawn_5
execute if score #cur kitpvp.tmp matches 6 as @r[tag=kitpvp.selected,tag=!kitpvp.spawn_assigned,tag=!kitpvp.spectator] run function kitpvp:map/arena/spawn_6
execute if score #cur kitpvp.tmp matches 7 as @r[tag=kitpvp.selected,tag=!kitpvp.spawn_assigned,tag=!kitpvp.spectator] run function kitpvp:map/arena/spawn_7
execute if score #cur kitpvp.tmp matches 8 as @r[tag=kitpvp.selected,tag=!kitpvp.spawn_assigned,tag=!kitpvp.spectator] run function kitpvp:map/arena/spawn_8
execute if score #cur kitpvp.tmp matches 9 as @r[tag=kitpvp.selected,tag=!kitpvp.spawn_assigned,tag=!kitpvp.spectator] run function kitpvp:map/arena/spawn_9
