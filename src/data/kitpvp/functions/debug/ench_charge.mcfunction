# 手动给两条各 +1 点（验证"加进度"这条路本身通不通）
execute as @p run scoreboard players add @s kitpvp.ench_sw 1
execute as @p run scoreboard players add @s kitpvp.ench_ap 1
execute as @p run playsound minecraft:block.note_block.chime master @s ~ ~ ~ 0.5 2.0
execute as @p run function kitpvp:skill/enchanter/ench_check
