# 位置 = 玩家脚下（4 格内有这只串联体时才跑）
# 近的那只：缓慢 II（4 秒一刷）；远的那只：速度 II（4 秒一刷）
# ★ 全部排除 tag=kitpvp.tanden_alone：独活强化的那只不能被这里的 clear 抹掉永久速度
effect clear @e[tag=kitpvp.earth_tanden,tag=!kitpvp.tanden_alone,distance=..4] minecraft:slowness
effect clear @e[tag=kitpvp.earth_tanden,tag=!kitpvp.tanden_alone,distance=..4] minecraft:speed
effect give @e[tag=kitpvp.earth_tanden,tag=!kitpvp.tanden_alone,distance=..4,sort=nearest,limit=1] minecraft:slowness 4 1 true
effect give @e[tag=kitpvp.earth_tanden,tag=!kitpvp.tanden_alone,distance=..4,sort=furthest,limit=1] minecraft:speed 4 1 true
