# @s = 被标记的那只（离玩家最近）。位置锚在它身上，才能量两只之间的距离
# ★ 缓慢已按要求整体移除：近的那只不挂任何效果；速度 II 只给另一只
effect clear @s minecraft:slowness
effect clear @s minecraft:speed
execute at @s run effect clear @e[tag=kitpvp.earth_tandem,tag=!kitpvp.tandem_near,tag=!kitpvp.tandem_alone] minecraft:slowness
# 另一只：速度 II（24 格内都算，不用贴着）
execute at @s run effect give @e[tag=kitpvp.earth_tandem,tag=!kitpvp.tandem_near,tag=!kitpvp.tandem_alone,distance=..24] minecraft:speed 3 1 true
# 被标记的那只脚下冒紫粒子（排查期保留，稳定后可删）
particle minecraft:end_rod ~ ~ ~ 0.2 0.1 0.2 0.02 6 normal
