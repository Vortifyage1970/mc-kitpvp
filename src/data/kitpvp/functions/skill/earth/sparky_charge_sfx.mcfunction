# @s = 电磁炮（执行位置在它身上）：充能中的音画反馈，三件事分开写便于单独调
# ---- 1) 电弧 ----
# 每刻 3 粒；过 120 点（6 秒）再加密到 6 粒 —— 视觉上"线圈越来越热"
execute at @s run particle minecraft:electric_spark ~ ~1.3 ~ 0.45 0.5 0.45 0.02 3 normal
execute if score @s kitpvp.sparky_charge matches 120..199 at @s run particle minecraft:electric_spark ~ ~1.5 ~ 0.6 0.7 0.6 0.05 6 normal

# ---- 2) 升调滴声 ----
# 每 20 刻（1 秒）一"滴"，音高随充能进度从 0.8 爬到 1.8（听感是"线圈转速在爬"）
# 计时器 sparky_beep 由 summon 埋初值 20；到 0 就重置成 20（所以每 20 刻正好响一次）
scoreboard players remove @s kitpvp.sparky_beep 1
execute if score @s kitpvp.sparky_beep matches ..0 run scoreboard players set @s kitpvp.sparky_beep 20
execute if score @s kitpvp.sparky_beep matches 20.. if score @s kitpvp.sparky_charge matches ..39 at @s run playsound minecraft:block.note_block.pling master @a[distance=..24] ~ ~ ~ 0.6 0.8
execute if score @s kitpvp.sparky_beep matches 20.. if score @s kitpvp.sparky_charge matches 40..79 at @s run playsound minecraft:block.note_block.pling master @a[distance=..24] ~ ~ ~ 0.6 1.0
execute if score @s kitpvp.sparky_beep matches 20.. if score @s kitpvp.sparky_charge matches 80..119 at @s run playsound minecraft:block.note_block.pling master @a[distance=..24] ~ ~ ~ 0.65 1.2
execute if score @s kitpvp.sparky_beep matches 20.. if score @s kitpvp.sparky_charge matches 120..159 at @s run playsound minecraft:block.note_block.pling master @a[distance=..24] ~ ~ ~ 0.7 1.4
execute if score @s kitpvp.sparky_beep matches 20.. if score @s kitpvp.sparky_charge matches 160..199 at @s run playsound minecraft:block.note_block.pling master @a[distance=..24] ~ ~ ~ 0.75 1.6
execute if score @s kitpvp.sparky_beep matches 20.. if score @s kitpvp.sparky_charge matches 200.. at @s run playsound minecraft:block.note_block.pling master @a[distance=..24] ~ ~ ~ 0.8 1.8

# ---- 3) 收尾嗡鸣 ----
# 过 180 点（9 秒）开始在炮口上叠一层高频蜂鸣，只在最后 1 秒响，预告"马上要开火"
execute if score @s kitpvp.sparky_charge matches 180..199 at @s run playsound minecraft:block.beacon.ambient master @a[distance=..16] ~ ~ ~ 0.6 1.9
# 满电那一帧：短促的"上膛"声，比放电的雷声早一拍，听感上像"咔——轰"
execute if score @s kitpvp.sparky_charge matches 200 at @s run playsound minecraft:block.respawn_anchor.charge master @a[distance=..24] ~ ~ ~ 0.8 1.6
