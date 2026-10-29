# 首行无条件推进快照，漏写会每刻连发
scoreboard players operation @s kitpvp.venus_arm_last = @s kitpvp.venus_arm_used

kill @e[type=minecraft:evoker,tag=kitpvp.venus_token,distance=..16]

execute if score @s kitpvp.cd2 matches ..0 run function kitpvp:skill/venus/arm_fire
execute if score @s kitpvp.cd2 matches 1.. run title @s actionbar {"text":"武装模块冷却中","color":"red"}
