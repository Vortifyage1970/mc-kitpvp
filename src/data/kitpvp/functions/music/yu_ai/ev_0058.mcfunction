# tick 709 | 音符 1
execute as @a at @s run playsound minecraft:block.note_block.harp master @s ~ ~ ~ 0.6669 1.1225
schedule function kitpvp:music/yu_ai/ev_0059 3t replace
tellraw @a {"text":"♪ 听雨的声音 一滴滴清晰 ♪","color":"light_purple","bold":true}
