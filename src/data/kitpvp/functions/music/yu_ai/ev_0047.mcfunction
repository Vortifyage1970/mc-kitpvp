# tick 592 | 音符 1
execute as @a at @s run playsound minecraft:block.note_block.harp master @s ~ ~ ~ 0.6669 1.1225
schedule function kitpvp:music/yu_ai/ev_0048 8t replace
tellraw @a {"text":"♪ 我的泪流在心里 学会放弃 ♪","color":"light_purple","bold":true}
