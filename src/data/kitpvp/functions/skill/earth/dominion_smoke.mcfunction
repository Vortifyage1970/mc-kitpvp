# 烟雾弹：每 2 刻在标记处补一轮黑烟，共 40 轮（80 条命 / 每轮减 1 ≈ 4 秒）
# 浓度用最初那版的参数：68 粒/轮 × 40 轮 = 2720 粒/团；速度参数调小让粒子别飞散（越快越稀）
# 每团各自计时（寿命只在出生时设一次）⇒ 新旧烟交替上镜、先后散去，不会同时消失
execute as @e[tag=kitpvp.earth_fw_mark] at @s run particle minecraft:large_smoke ~ ~ ~ 3 1.4 3 0.02 26 normal
execute as @e[tag=kitpvp.earth_fw_mark] at @s run particle minecraft:squid_ink ~ ~ ~ 3.2 1.6 3.2 0.015 18 normal
execute as @e[tag=kitpvp.earth_fw_mark] at @s run particle minecraft:campfire_signal_smoke ~ ~ ~ 2.6 1 2.6 0.01 10 normal
execute as @e[tag=kitpvp.earth_fw_mark] at @s run particle minecraft:smoke ~ ~ ~ 4.5 2.2 4.5 0.02 14 normal
scoreboard players remove @e[tag=kitpvp.earth_fw_mark] kitpvp.earth_fw_life 1
execute as @e[tag=kitpvp.earth_fw_mark,scores={kitpvp.earth_fw_life=..0}] run kill @s
# 只要场上还有标记就继续循环；标记都清掉了就自然停下（不会空转）
execute if entity @e[tag=kitpvp.earth_fw_mark] run schedule function kitpvp:skill/earth/dominion_smoke 2t replace
