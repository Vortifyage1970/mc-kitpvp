# 烟花炸开那一帧的黑烟：三层叠加出"很大一团"
# large_smoke 是主烟柱（深色、块状），campfire_signal_smoke 往上飘着散开，smoke 补外圈稀薄的一层
execute as @e[tag=kitpvp.earth_fw_mark] at @s run particle minecraft:large_smoke ~ ~ ~ 3.5 1.5 3.5 0.02 220 normal
execute as @e[tag=kitpvp.earth_fw_mark] at @s run particle minecraft:campfire_signal_smoke ~ ~ ~ 3.5 1.2 3.5 0.01 140 normal
execute as @e[tag=kitpvp.earth_fw_mark] at @s run particle minecraft:smoke ~ ~ ~ 5 2 5 0.02 160 normal
# 顺带一圈黑灰火星，让边缘不至于太"方"
execute as @e[tag=kitpvp.earth_fw_mark] at @s run particle minecraft:ash ~ ~ ~ 3 1 3 0.01 90 normal
kill @e[tag=kitpvp.earth_fw_mark]
