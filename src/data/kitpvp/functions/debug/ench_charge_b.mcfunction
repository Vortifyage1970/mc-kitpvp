# 再 +1 点（连按两次就能看到 2/3，第三次升级）
execute as @p run scoreboard players add @s kitpvp.ench_sw 1
execute as @p run scoreboard players add @s kitpvp.ench_ap 1
execute as @p run playsound minecraft:block.note_block.chime master @s ~ ~ ~ 0.5 2.0
execute as @p run function kitpvp:skill/enchanter/ench_check
