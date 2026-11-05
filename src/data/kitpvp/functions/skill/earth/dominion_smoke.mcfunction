# 烟雾弹：每 2 刻在标记处补一轮黑烟，共 16 轮（32 条命 / 每轮减 1 ≈ 1.6 秒）
# 掉帧是"同时在场的粒子总数"决定的：这一版 60 粒/轮 × 16 轮 = 960 粒（上一版 98×40 = 3920，砍到 1/4）
# 散得快 = 速度参数调大（粒子尽快飞走消失），停留时间靠 earth_fw_life 控制
execute as @e[tag=kitpvp.earth_fw_mark] at @s run particle minecraft:large_smoke ~ ~ ~ 2.4 1.2 2.4 0.05 24 normal
execute as @e[tag=kitpvp.earth_fw_mark] at @s run particle minecraft:squid_ink ~ ~ ~ 2.6 1.4 2.6 0.045 16 normal
execute as @e[tag=kitpvp.earth_fw_mark] at @s run particle minecraft:campfire_signal_smoke ~ ~ ~ 2.2 0.9 2.2 0.04 8 normal
execute as @e[tag=kitpvp.earth_fw_mark] at @s run particle minecraft:smoke ~ ~ ~ 3.8 1.8 3.8 0.05 12 normal
scoreboard players remove @e[tag=kitpvp.earth_fw_mark] kitpvp.earth_fw_life 1
execute as @e[tag=kitpvp.earth_fw_mark,scores={kitpvp.earth_fw_life=..0}] run kill @s
# 只要场上还有标记就继续循环；标记都清掉了就自然停下（不会空转）
execute if entity @e[tag=kitpvp.earth_fw_mark] run schedule function kitpvp:skill/earth/dominion_smoke 2t replace
