# @s = 电磁炮（执行位置在它身上）：8 秒充能的听觉设计 —— 电子滴滴爬升 → 蜂鸣 → 上膛

# ---- 1) 电弧：每刻 3 粒；过 96 点（4.8 秒）加密到 6 粒 ----
execute at @s run particle minecraft:electric_spark ~ ~1.3 ~ 0.45 0.5 0.45 0.02 3 normal
execute if score @s kitpvp.sparky_charge matches 96..159 at @s run particle minecraft:electric_spark ~ ~1.5 ~ 0.6 0.7 0.6 0.05 6 normal

# ---- 2) 电子滴声：每 20 刻（1 秒）一响，pitch 从 0.7 爬到 1.5 ----
# note_block.bit 是方波电子音，比 pling 更像线圈在充电；音量 0.55 不抢戏，但 24 格内都听得到
scoreboard players remove @s kitpvp.sparky_beep 1
execute if score @s kitpvp.sparky_beep matches ..0 run scoreboard players set @s kitpvp.sparky_beep 20
execute if score @s kitpvp.sparky_beep matches 20.. if score @s kitpvp.sparky_charge matches ..31 at @s run playsound minecraft:block.note_block.bit master @a[distance=..24] ~ ~ ~ 0.55 0.7
execute if score @s kitpvp.sparky_beep matches 20.. if score @s kitpvp.sparky_charge matches 32..63 at @s run playsound minecraft:block.note_block.bit master @a[distance=..24] ~ ~ ~ 0.6 0.9
execute if score @s kitpvp.sparky_beep matches 20.. if score @s kitpvp.sparky_charge matches 64..95 at @s run playsound minecraft:block.note_block.bit master @a[distance=..24] ~ ~ ~ 0.65 1.1
execute if score @s kitpvp.sparky_beep matches 20.. if score @s kitpvp.sparky_charge matches 96..127 at @s run playsound minecraft:block.note_block.bit master @a[distance=..24] ~ ~ ~ 0.7 1.3
execute if score @s kitpvp.sparky_beep matches 20.. if score @s kitpvp.sparky_charge matches 128..159 at @s run playsound minecraft:block.note_block.bit master @a[distance=..24] ~ ~ ~ 0.75 1.5

# ---- 3) 最后 1 秒叠金属撞击（144 起），和滴声错开一拍，听感是"叮…铛" ----
execute if score @s kitpvp.sparky_beep matches 20.. if score @s kitpvp.sparky_charge matches 144..159 at @s run playsound minecraft:block.anvil.land master @a[distance=..24] ~ ~ ~ 0.45 1.8

# ---- 4) 蜂鸣：过 144 点（7.2 秒）叠高频蜂鸣，过 152 点（7.6 秒）叠低频上膛前的嗡 ----
execute if score @s kitpvp.sparky_charge matches 144..159 at @s run playsound minecraft:block.beacon.ambient master @a[distance=..16] ~ ~ ~ 0.55 1.9
execute if score @s kitpvp.sparky_charge matches 152..159 at @s run playsound minecraft:block.respawn_anchor.ambient master @a[distance=..24] ~ ~ ~ 0.6 0.7

# ---- 5) 满电：钟声 + 上膛声，紧跟着才是放电的雷 ----
execute if score @s kitpvp.sparky_charge matches 160 at @s run playsound minecraft:block.respawn_anchor.charge master @a[distance=..32] ~ ~ ~ 0.9 1.4
execute if score @s kitpvp.sparky_charge matches 160 at @s run playsound minecraft:block.note_block.bell master @a[distance=..32] ~ ~ ~ 0.7 1.9
