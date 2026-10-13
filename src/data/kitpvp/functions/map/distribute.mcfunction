# 按 #global kitpvp.map 分发到各图的 distribute
tag @a[tag=kitpvp.selected] remove kitpvp.spawn_assigned

execute if score #global kitpvp.map matches 1 run function kitpvp:map/desert/distribute
execute if score #global kitpvp.map matches 2 run function kitpvp:map/arena/distribute
execute if score #global kitpvp.map matches 7 run function kitpvp:map/earth/distribute
execute if score #global kitpvp.map matches 8 run function kitpvp:map/xian/distribute
