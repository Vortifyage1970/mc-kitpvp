# @s = 慢的那只（离玩家最近）。位置锚在它身上，才能量两只之间的距离
# 不再用传送维持队形：拉开就"同步降速"让它自己等，贴回来立刻恢复速度 II
effect clear @s minecraft:speed
effect give @s minecraft:slowness 2 1 true
# 快的那只：4 格内 → 速度 II（有精神地跟着）
execute at @s run effect clear @e[tag=kitpvp.earth_tandem,tag=!kitpvp.tandem_near,tag=!kitpvp.tandem_alone,distance=..4] minecraft:slowness
execute at @s run effect give @e[tag=kitpvp.earth_tandem,tag=!kitpvp.tandem_near,tag=!kitpvp.tandem_alone,distance=..4] minecraft:speed 2 1 true
# 超过 4 格 → 撤速度、补缓慢 I（≈ -15%），让它慢慢被追平；不用传送，观感是"它回头等你"
execute at @s run effect clear @e[tag=kitpvp.earth_tandem,tag=!kitpvp.tandem_near,tag=!kitpvp.tandem_alone,distance=4..] minecraft:speed
execute at @s run effect give @e[tag=kitpvp.earth_tandem,tag=!kitpvp.tandem_near,tag=!kitpvp.tandem_alone,distance=4..,limit=1] minecraft:slowness 1 2 true
# 近的那只脚下冒紫粒子（排查期保留，稳定后可删）
particle minecraft:end_rod ~ ~ ~ 0.2 0.1 0.2 0.02 6 normal
