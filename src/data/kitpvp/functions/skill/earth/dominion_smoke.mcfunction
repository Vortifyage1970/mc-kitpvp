# 烟雾弹：每 2 刻在标记处补一轮黑烟，共 20 轮（40 条命 / 每轮减 1）
# 浓度就是要"多"：一轮 68 粒 × 20 轮 = 1360 粒堆在 6×3×6 的团里，速度参数调小让粒子别飞散（越快越稀）
# 四种粒子分工：large_smoke 出体量、squid_ink 压暗（纯黑的烟靠它）、campfire_signal_smoke 往上飘、smoke 铺外圈
execute as @e[tag=kitpvp.earth_fw_mark] at @s run particle minecraft:large_smoke ~ ~ ~ 3 1.4 3 0.02 26 normal
execute as @e[tag=kitpvp.earth_fw_mark] at @s run particle minecraft:squid_ink ~ ~ ~ 3.2 1.6 3.2 0.015 18 normal
execute as @e[tag=kitpvp.earth_fw_mark] at @s run particle minecraft:campfire_signal_smoke ~ ~ ~ 2.6 1 2.6 0.01 10 normal
execute as @e[tag=kitpvp.earth_fw_mark] at @s run particle minecraft:smoke ~ ~ ~ 4.5 2.2 4.5 0.02 14 normal
scoreboard players remove @e[tag=kitpvp.earth_fw_mark] kitpvp.earth_fw_life 1
execute as @e[tag=kitpvp.earth_fw_mark,scores={kitpvp.earth_fw_life=..0}] run kill @s
# 只要场上还有标记就继续循环；标记都清掉了就自然停下（不会空转）
execute if entity @e[tag=kitpvp.earth_fw_mark] run schedule function kitpvp:skill/earth/dominion_smoke 2t replace
