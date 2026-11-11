# 矿车到点（40 秒）：连蠹虫带背上的船一起自毁（2026-11-10 从"原地停住"改成"自毁"）
# stopped 标签只是防止同一刻被 tick 里那条 ..0 判定重复触发（kill 要下一 tick 才生效）
tag @s add kitpvp.earth_minecart_stopped
execute at @s run kill @e[type=minecraft:boat,tag=kitpvp.earth_minecart_boat,distance=..2]
particle minecraft:cloud ~ ~0.4 ~ 0.35 0.25 0.35 0.01 10 normal
playsound minecraft:block.piston.contract master @a[distance=..16] ~ ~ ~ 0.7 1.2
kill @s
