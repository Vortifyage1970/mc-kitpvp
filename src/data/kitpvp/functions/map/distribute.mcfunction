# 按 #global kitpvp.map 分发到各图的 distribute
tag @a[tag=kitpvp.selected] remove kitpvp.spawn_assigned

# 出生点锚点跟着本局重建：先清掉上一局的，否则重生兜底会把人送回旧地图的坐标（见 04 §十一）
kill @e[tag=kitpvp.spawn_anchor]

execute if score #global kitpvp.map matches 1 run function kitpvp:map/desert/distribute
execute if score #global kitpvp.map matches 2 run function kitpvp:map/arena/distribute
execute if score #global kitpvp.map matches 3 run function kitpvp:map/snow/distribute
execute if score #global kitpvp.map matches 7 run function kitpvp:map/earth/distribute
execute if score #global kitpvp.map matches 8 run function kitpvp:map/xian/distribute
execute if score #global kitpvp.map matches 9 run function kitpvp:map/mansion/distribute
execute if score #global kitpvp.map matches 10 run function kitpvp:map/cobblestone/distribute
execute if score #global kitpvp.map matches 11 run function kitpvp:map/toronto/distribute
