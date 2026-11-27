scoreboard players add @s kitpvp.ench_sw_fill 60
execute if score @s kitpvp.ench_sw_fill matches 300.. run function kitpvp:skill/li_ench/fill_sw
title @s actionbar [{"text":"◆ 抽到：","color":"white"},{"text":"磨刀","color":"white","bold":true},{"text":"（剑进度 +0.2）","color":"gray"}]
playsound minecraft:block.note_block.pling master @s ~ ~ ~ 0.6 1.7
