# @s = 土星（as @s at @s）：把「轨道」蠹虫摆成绕身一圈
# 8 个位置按相位取，相位在 tick.mcfunction 里每 4 刻 +1（绕一圈 32 刻 = 1.6 秒）
# 高度都在身体上（0.7~1.1），配合 NoGravity，永远不会落到地表
tp @e[tag=kitpvp.sat_orbit,distance=..8,scores={kitpvp.sat_phase=0}] ~1.5 ~0.9 ~
tp @e[tag=kitpvp.sat_orbit,distance=..8,scores={kitpvp.sat_phase=1}] ~1.06 ~1.0 ~1.06
tp @e[tag=kitpvp.sat_orbit,distance=..8,scores={kitpvp.sat_phase=2}] ~0 ~1.1 ~1.5
tp @e[tag=kitpvp.sat_orbit,distance=..8,scores={kitpvp.sat_phase=3}] ~-1.06 ~1.0 ~1.06
tp @e[tag=kitpvp.sat_orbit,distance=..8,scores={kitpvp.sat_phase=4}] ~-1.5 ~0.9 ~
tp @e[tag=kitpvp.sat_orbit,distance=..8,scores={kitpvp.sat_phase=5}] ~-1.06 ~0.8 ~-1.06
tp @e[tag=kitpvp.sat_orbit,distance=..8,scores={kitpvp.sat_phase=6}] ~0 ~0.7 ~-1.5
tp @e[tag=kitpvp.sat_orbit,distance=..8,scores={kitpvp.sat_phase=7}] ~1.06 ~0.8 ~-1.06
