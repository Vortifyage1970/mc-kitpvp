# 排查用：站在串联体旁边跑 /function kitpvp:debug/tandem_check
tellraw @s [{"text":"=== 串联体 · a 半身 ===","color":"gold","bold":true}]
tellraw @s [{"text":"效果 ","color":"gray"},{"nbt":"ActiveEffects","entity":"@e[tag=kitpvp.earth_tandem_a,limit=1]"}]
tellraw @s [{"text":"=== 串联体 · b 半身 ===","color":"aqua","bold":true}]
tellraw @s [{"text":"效果 ","color":"gray"},{"nbt":"ActiveEffects","entity":"@e[tag=kitpvp.earth_tandem_b,limit=1]"}]
tellraw @s [{"text":"读法：每 2 秒只有一边带 speed(id 1, amplifier 1 = 速度 II)，另一边是空的；两边都有 = 叠加了","color":"dark_gray","italic":true}]
scoreboard players get #td_alt kitpvp.game
