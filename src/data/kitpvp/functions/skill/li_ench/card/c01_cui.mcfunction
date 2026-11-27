scoreboard players add @s kitpvp.ench_ap_fill 60
execute if score @s kitpvp.ench_ap_fill matches 300.. run function kitpvp:skill/enchanter/fill_ap
title @s actionbar [{"text":"◆ 抽到：","color":"white"},{"text":"淬甲","color":"white","bold":true},{"text":"（护甲进度 +0.2）","color":"gray"}]
playsound minecraft:block.note_block.pling master @s ~ ~ ~ 0.6 1.2
