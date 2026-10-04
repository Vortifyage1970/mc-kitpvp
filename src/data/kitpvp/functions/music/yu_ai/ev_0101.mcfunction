# tick 1072 | 音符 1
execute as @a at @s run playsound minecraft:block.note_block.harp master @s ~ ~ ~ 0.6669 1
schedule function kitpvp:music/yu_ai/ev_0102 4t replace
tellraw @a {"text":"♪ 我爱上给我勇气的 ♪","color":"light_purple","bold":true}