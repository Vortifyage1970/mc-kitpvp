# 音符盒死亡音效：自然小调（Aeolian）下行八音，从 2.0 落到 1.0，每 4 刻一个（共 1.6 秒，放慢一倍）
# 音高 = 2 的 (半音/12) 次方：2.000 1.782 1.682 1.498 1.335 1.260 1.122 1.000
# 想让听感更"悲"可以把第 3、6 个音再压低半音（1.682→1.587、1.260→1.189），那就是弗里吉亚调式
scoreboard players add #nb_death kitpvp.game 1
execute if score #nb_death kitpvp.game matches 1 run playsound minecraft:block.note_block.bass master @a[distance=..32] ~ ~ ~ 2.0 2.000
execute if score #nb_death kitpvp.game matches 2 run playsound minecraft:block.note_block.bass master @a[distance=..32] ~ ~ ~ 2.0 1.782
execute if score #nb_death kitpvp.game matches 3 run playsound minecraft:block.note_block.bass master @a[distance=..32] ~ ~ ~ 2.0 1.682
execute if score #nb_death kitpvp.game matches 4 run playsound minecraft:block.note_block.bass master @a[distance=..32] ~ ~ ~ 2.0 1.498
execute if score #nb_death kitpvp.game matches 5 run playsound minecraft:block.note_block.bass master @a[distance=..32] ~ ~ ~ 2.0 1.335
execute if score #nb_death kitpvp.game matches 6 run playsound minecraft:block.note_block.bass master @a[distance=..32] ~ ~ ~ 2.0 1.260
execute if score #nb_death kitpvp.game matches 7 run playsound minecraft:block.note_block.bass master @a[distance=..32] ~ ~ ~ 2.0 1.122
execute if score #nb_death kitpvp.game matches 8 run playsound minecraft:block.note_block.bass master @a[distance=..32] ~ ~ ~ 2.0 1.000
execute if score #nb_death kitpvp.game matches ..7 run schedule function kitpvp:skill/earth/noteblock_cascade 4t append
