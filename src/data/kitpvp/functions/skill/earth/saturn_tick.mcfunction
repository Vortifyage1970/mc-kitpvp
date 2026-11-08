# @s = 土星（as @s at @s）：把 8 只「轨道」蠹虫摆成绕身一圈
# 8 个位置按相位取，相位在 tick.mcfunction 里每 4 刻 +1（绕一圈 32 刻 = 1.6 秒）
# 半径 2.2，高度 0.7~1.1（腰到胸口这一圈），配合 NoGravity，永远不会落到地表
tp @e[tag=kitpvp.sat_orbit,distance=..8,scores={kitpvp.sat_phase=0}] ~2.2 ~0.9 ~
tp @e[tag=kitpvp.sat_orbit,distance=..8,scores={kitpvp.sat_phase=1}] ~1.56 ~1.0 ~1.56
tp @e[tag=kitpvp.sat_orbit,distance=..8,scores={kitpvp.sat_phase=2}] ~0 ~1.1 ~2.2
tp @e[tag=kitpvp.sat_orbit,distance=..8,scores={kitpvp.sat_phase=3}] ~-1.56 ~1.0 ~1.56
tp @e[tag=kitpvp.sat_orbit,distance=..8,scores={kitpvp.sat_phase=4}] ~-2.2 ~0.9 ~
tp @e[tag=kitpvp.sat_orbit,distance=..8,scores={kitpvp.sat_phase=5}] ~-1.56 ~0.8 ~-1.56
tp @e[tag=kitpvp.sat_orbit,distance=..8,scores={kitpvp.sat_phase=6}] ~0 ~0.7 ~-2.2
tp @e[tag=kitpvp.sat_orbit,distance=..8,scores={kitpvp.sat_phase=7}] ~1.56 ~0.8 ~-1.56