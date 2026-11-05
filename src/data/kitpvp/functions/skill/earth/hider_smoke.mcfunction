# 烟雾弹：每 2 刻在标记处补一轮黑烟，共 20 轮（40 条命 / 每轮减 1）
# 浓度靠"多 + 收"：98 粒/轮 × 20 轮 = 1960 粒堆在 5×3×5 的团里；散布半径收小、速度参数压到 0.01，粒子就近抱团不飞散
# 四种粒子分工：large_smoke 出体量、squid_ink 压暗（纯黑的烟靠它）、campfire_signal_smoke 往上飘、smoke 铺外圈
execute as @e[tag=kitpvp.earth_fw_mark] at @s run particle minecraft:large_smoke ~ ~ ~ 2.4 1.2 2.4 0.012 38 normal
execute as @e[tag=kitpvp.earth_fw_mark] at @s run particle minecraft:squid_ink ~ ~ ~ 2.6 1.4 2.6 0.01 26 normal
execute as @e[tag=kitpvp.earth_fw_mark] at @s run particle minecraft:campfire_signal_smoke ~ ~ ~ 2.2 0.9 2.2 0.008 14 normal
execute as @e[tag=kitpvp.earth_fw_mark] at @s run particle minecraft:smoke ~ ~ ~ 3.8 1.8 3.8 0.012 20 normal
scoreboard players remove @e[tag=kitpvp.earth_fw_mark] kitpvp.earth_fw_life 1
execute as @e[tag=kitpvp.earth_fw_mark,scores={kitpvp.earth_fw_life=..0}] run kill @s
# 只要场上还有标记就继续循环；标记都清掉了就自然停下（不会空转）
execute if entity @e[tag=kitpvp.earth_fw_mark] run schedule function kitpvp:skill/earth/hider_smoke 2t replace
