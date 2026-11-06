# 矿车到点：原地停住（NoAI 关掉寻路与挥爪）。它本来就带虚弱 X、打人不掉血，所以"不能再打"没有代价
# 只停不杀：血照样能被玩家打掉，reset 的按 tag 清场也照旧
tag @s add kitpvp.earth_minecart_stopped
data merge entity @s {NoAI:1b}
particle minecraft:cloud ~ ~0.4 ~ 0.35 0.25 0.35 0.01 10 normal
playsound minecraft:block.piston.contract master @a[distance=..16] ~ ~ ~ 0.7 1.2
title @a[distance=..16] actionbar [{"text":"矿车","color":"gray"},{"text":" 熄火了","color":"dark_gray"}]
