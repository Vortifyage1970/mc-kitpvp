# 烟雾弹：每 2 刻在标记处补一轮黑烟，共 14 轮（28 条命 / 每轮减 1 ≈ 1.4 秒）
# 掉帧看"同时在场的粒子总数"：76 粒/轮 × 14 轮 = 1064 粒/团（最初那版是 68×20 = 1360）；单只内卫同时只有 1 团
# 散得快 = 速度参数调大（粒子尽快飞走消失），停留时间靠 earth_fw_life 控制
execute as @e[tag=kitpvp.earth_fw_mark] at @s run particle minecraft:large_smoke ~ ~ ~ 2.5 1.3 2.5 0.04 30 normal
execute as @e[tag=kitpvp.earth_fw_mark] at @s run particle minecraft:squid_ink ~ ~ ~ 2.7 1.5 2.7 0.035 20 normal
execute as @e[tag=kitpvp.earth_fw_mark] at @s run particle minecraft:campfire_signal_smoke ~ ~ ~ 2.3 1.0 2.3 0.03 10 normal
execute as @e[tag=kitpvp.earth_fw_mark] at @s run particle minecraft:smoke ~ ~ ~ 4.0 1.9 4.0 0.04 16 normal
scoreboard players remove @e[tag=kitpvp.earth_fw_mark] kitpvp.earth_fw_life 1
execute as @e[tag=kitpvp.earth_fw_mark,scores={kitpvp.earth_fw_life=..0}] run kill @s
# 只要场上还有标记就继续循环；标记都清掉了就自然停下（不会空转）
execute if entity @e[tag=kitpvp.earth_fw_mark] run schedule function kitpvp:skill/earth/dominion_smoke 2t replace
