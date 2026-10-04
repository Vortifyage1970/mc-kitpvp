# tick 218 | 音符 1
execute as @a at @s run playsound minecraft:block.note_block.harp master @s ~ ~ ~ 0.6669 0.8909
schedule function kitpvp:music/yu_ai/ev_0015 7t replace
tellraw @a {"text":"♪ 下雨了 ♪","color":"light_purple","bold":true}
