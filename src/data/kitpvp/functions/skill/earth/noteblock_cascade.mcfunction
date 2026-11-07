# @s = 死亡音符盒留下的"弹音器" marker（noteblock_death 放在死亡地点）；由 tick 每刻 at @s 调进来
# 自然小调（Aeolian）下行八音：2.000 1.782 1.682 1.498 1.335 1.260 1.122 1.000
# 每 3 刻一个音，共 22 刻（约 1.1 秒），弹完第 8 个音就把 marker 收掉
scoreboard players add @s kitpvp.nb_step 1
execute if score @s kitpvp.nb_step matches 1 run playsound minecraft:block.note_block.harp master @a[distance=..32] ~ ~ ~ 2.0 2.000
execute if score @s kitpvp.nb_step matches 4 run playsound minecraft:block.note_block.harp master @a[distance=..32] ~ ~ ~ 2.0 1.782
execute if score @s kitpvp.nb_step matches 7 run playsound minecraft:block.note_block.harp master @a[distance=..32] ~ ~ ~ 2.0 1.682
execute if score @s kitpvp.nb_step matches 10 run playsound minecraft:block.note_block.harp master @a[distance=..32] ~ ~ ~ 2.0 1.498
execute if score @s kitpvp.nb_step matches 13 run playsound minecraft:block.note_block.harp master @a[distance=..32] ~ ~ ~ 2.0 1.335
execute if score @s kitpvp.nb_step matches 16 run playsound minecraft:block.note_block.harp master @a[distance=..32] ~ ~ ~ 2.0 1.260
execute if score @s kitpvp.nb_step matches 19 run playsound minecraft:block.note_block.harp master @a[distance=..32] ~ ~ ~ 2.0 1.122
execute if score @s kitpvp.nb_step matches 22 run playsound minecraft:block.note_block.harp master @a[distance=..32] ~ ~ ~ 2.0 1.000
execute if score @s kitpvp.nb_step matches 23.. run kill @s
