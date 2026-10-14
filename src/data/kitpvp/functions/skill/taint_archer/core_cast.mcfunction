# 首行无条件推进快照，漏写会每刻重复触发
scoreboard players operation @s kitpvp.taint_core_last = @s kitpvp.taint_core_used

execute if score @s kitpvp.cd matches ..0 run function kitpvp:skill/taint_archer/core_fire
execute if score @s kitpvp.cd matches 1.. run title @s actionbar {"text":"熔火核心冷却中","color":"gray"}
