scoreboard players add @s kitpvp.ench_sw_fill 150
execute if score @s kitpvp.ench_sw_fill matches 300.. run function kitpvp:skill/enchanter/fill_sw
title @s actionbar [{"text":"◇ 抽到：","color":"aqua"},{"text":"精磨","color":"aqua","bold":true},{"text":"（剑进度 +0.5）","color":"gray"}]
playsound minecraft:block.note_block.chime master @s ~ ~ ~ 0.7 1.6
