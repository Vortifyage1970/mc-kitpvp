# @s = 被标记的那只（离玩家最近）。位置锚在它身上，才能量两只之间的距离
# ★ 全场只有这一只吃缓慢；另一只永远不挂缓慢，否则就成了"两只都减速"
effect clear @s minecraft:speed
effect give @s minecraft:slowness 2 1 true
execute at @s run effect clear @e[tag=kitpvp.earth_tandem,tag=!kitpvp.tandem_near,tag=!kitpvp.tandem_alone] minecraft:slowness
# 另一只：4 格内给速度 II；拉开 4 格就撤速度（走基础速度，慢慢被追平），但绝不补缓慢
execute at @s run effect give @e[tag=kitpvp.earth_tandem,tag=!kitpvp.tandem_near,tag=!kitpvp.tandem_alone,distance=..4] minecraft:speed 2 1 true
execute at @s run effect clear @e[tag=kitpvp.earth_tandem,tag=!kitpvp.tandem_near,tag=!kitpvp.tandem_alone,distance=4..] minecraft:speed
# 被标记的那只脚下冒紫粒子（排查期保留，稳定后可删）
particle minecraft:end_rod ~ ~ ~ 0.2 0.1 0.2 0.02 6 normal
