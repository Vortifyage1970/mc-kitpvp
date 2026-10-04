# tick 772 | 音符 1
execute as @a at @s run playsound minecraft:block.note_block.harp master @s ~ ~ ~ 0.6669 1.1225
schedule function kitpvp:music/yu_ai/ev_0069 4t replace
tellraw @a {"text":"♪ 你的呼吸像雨滴渗入我的爱里 ♪","color":"light_purple","bold":true}
