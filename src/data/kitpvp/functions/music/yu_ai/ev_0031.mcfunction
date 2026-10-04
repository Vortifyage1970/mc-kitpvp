# tick 458 | 音符 1
execute as @a at @s run playsound minecraft:block.note_block.harp master @s ~ ~ ~ 0.6669 1.1225
schedule function kitpvp:music/yu_ai/ev_0032 7t replace
tellraw @a {"text":"♪ 离开你 我安静地抽离 ♪","color":"light_purple","bold":true}