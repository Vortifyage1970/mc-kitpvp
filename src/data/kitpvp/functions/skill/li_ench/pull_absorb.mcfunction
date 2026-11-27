# 伤害吸收：20 点（吸收 V = 20 点），30 秒
effect give @s minecraft:absorption 600 4 true
title @s actionbar [{"text":"◆ 伤害吸收 20 点","color":"yellow"},{"text":"（30 秒）","color":"gray"}]
playsound minecraft:block.beacon.activate master @s ~ ~ ~ 0.6 1.4
