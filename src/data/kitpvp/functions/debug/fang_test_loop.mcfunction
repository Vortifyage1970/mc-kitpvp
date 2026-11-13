# 尖牙测试的节拍器：每刻减 1，到点就放，然后自己续约 —— 只给 debug 用，正式生灵请挂在 tick.mcfunction 里
scoreboard players remove @e[tag=kitpvp.fang_test] kitpvp.fang_cd 1
execute as @e[tag=kitpvp.fang_test,scores={kitpvp.fang_cd=..0},limit=1] at @s run function kitpvp:debug/fang_cast
execute if entity @e[tag=kitpvp.fang_test] run schedule function kitpvp:debug/fang_test_loop 1t replace
