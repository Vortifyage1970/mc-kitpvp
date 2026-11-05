# 烟雾弹：每 2 刻在标记处补一轮黑烟，共 20 轮（40 条命 / 每轮减 1）
# 三种粒子分工：large_smoke 出体量、squid_ink 压暗（纯黑的烟靠它）、campfire_signal_smoke 往上飘散
execute as @e[tag=kitpvp.earth_fw_mark] at @s run particle minecraft:large_smoke ~ ~ ~ 2.5 1.2 2.5 0.03 14 normal
execute as @e[tag=kitpvp.earth_fw_mark] at @s run particle minecraft:squid_ink ~ ~ ~ 2.8 1.4 2.8 0.02 10 normal
execute as @e[tag=kitpvp.earth_fw_mark] at @s run particle minecraft:campfire_signal_smoke ~ ~ ~ 2.2 0.8 2.2 0.01 6 normal
execute as @e[tag=kitpvp.earth_fw_mark] at @s run particle minecraft:smoke ~ ~ ~ 4 2 4 0.02 8 normal
scoreboard players remove @e[tag=kitpvp.earth_fw_mark] kitpvp.earth_fw_life 1
execute as @e[tag=kitpvp.earth_fw_mark,scores={kitpvp.earth_fw_life=..0}] run kill @s
# 只要场上还有标记就继续循环；标记都清掉了就自然停下（不会空转）
execute if entity @e[tag=kitpvp.earth_fw_mark] run schedule function kitpvp:skill/earth/hider_smoke 2t replace
