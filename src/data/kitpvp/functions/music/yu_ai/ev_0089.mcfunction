# tick 952 | 音符 1
execute as @a at @s run playsound minecraft:block.note_block.harp master @s ~ ~ ~ 0.6669 0.6674
schedule function kitpvp:music/yu_ai/ev_0090 8t replace
tellraw @a {"text":"♪ 让想念继续 让爱变透明 ♪","color":"light_purple","bold":true}