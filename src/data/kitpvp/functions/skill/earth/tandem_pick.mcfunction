# 效果给 2 秒、每 1 秒重算一次：刷新永远比过期快，切换时不会有一帧没有效果
# 位置 = 玩家脚下。★ 关键：不能用 sort=furthest 找"远的那只"——
#   当一对里只有一只在 4 格内时，nearest 和 furthest 会选中同一只，于是它既+40%速度又-30%速度，等于没有差别
# 正确做法：先给两只都挂速度 II，再把"最近那只"的速度清掉、换成缓慢 II
effect clear @e[tag=kitpvp.earth_tandem,tag=!kitpvp.tandem_alone,distance=..24] minecraft:slowness
effect give @e[tag=kitpvp.earth_tandem,tag=!kitpvp.tandem_alone,distance=..24] minecraft:speed 2 1 true
effect give @e[tag=kitpvp.earth_tandem,tag=!kitpvp.tandem_alone,distance=..24,sort=nearest,limit=1] minecraft:slowness 2 1 true
effect clear @e[tag=kitpvp.earth_tandem,tag=!kitpvp.tandem_alone,distance=..24,sort=nearest,limit=1] minecraft:speed
