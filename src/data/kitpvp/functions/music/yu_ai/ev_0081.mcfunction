# tick 878 | 音符 1
execute as @a at @s run playsound minecraft:block.note_block.harp master @s ~ ~ ~ 0.6669 0.8909
schedule function kitpvp:music/yu_ai/ev_0082 7t replace
tellraw @a {"text":"♪ 真希望雨能下不停 ♪","color":"light_purple","bold":true}