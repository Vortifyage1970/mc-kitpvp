# 音符盒死亡音效：从 2.0 一路降到 0.5，每 2 刻一个音（共 8 个 = 0.8 秒），像"通关失败"的下落音阶
# 用假玩家 #nb_death 记步数，自己 schedule 自己；打完第 8 个就不再排
scoreboard players add #nb_death kitpvp.game 1
execute if score #nb_death kitpvp.game matches 1 run playsound minecraft:block.note_block.bell master @a[distance=..32] ~ ~ ~ 1.0 2.0
execute if score #nb_death kitpvp.game matches 2 run playsound minecraft:block.note_block.bell master @a[distance=..32] ~ ~ ~ 1.0 1.8
execute if score #nb_death kitpvp.game matches 3 run playsound minecraft:block.note_block.flute master @a[distance=..32] ~ ~ ~ 1.0 1.6
execute if score #nb_death kitpvp.game matches 4 run playsound minecraft:block.note_block.flute master @a[distance=..32] ~ ~ ~ 1.0 1.4
execute if score #nb_death kitpvp.game matches 5 run playsound minecraft:block.note_block.harp master @a[distance=..32] ~ ~ ~ 1.0 1.2
execute if score #nb_death kitpvp.game matches 6 run playsound minecraft:block.note_block.harp master @a[distance=..32] ~ ~ ~ 1.0 1.0
execute if score #nb_death kitpvp.game matches 7 run playsound minecraft:block.note_block.bass master @a[distance=..32] ~ ~ ~ 1.0 0.75
execute if score #nb_death kitpvp.game matches 8 run playsound minecraft:block.note_block.bass master @a[distance=..32] ~ ~ ~ 1.0 0.5
execute if score #nb_death kitpvp.game matches ..7 run schedule function kitpvp:skill/earth/noteblock_cascade 2t append
