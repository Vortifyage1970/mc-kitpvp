# 真正咬下去：在 marker 位置召一只原版尖牙（自带约 20 刻预热 = 还会再挑一下）
execute at @e[tag=kitpvp.fang_at] run summon minecraft:evoker_fangs ~ ~ ~
execute at @e[tag=kitpvp.fang_at] run particle minecraft:crit ~ ~0.2 ~ 0.3 0.1 0.3 0.05 20
execute at @e[tag=kitpvp.fang_at] run playsound minecraft:entity.evoker.cast_spell hostile @a[distance=..16] ~ ~ ~ 1 1.1
kill @e[tag=kitpvp.fang_at]
