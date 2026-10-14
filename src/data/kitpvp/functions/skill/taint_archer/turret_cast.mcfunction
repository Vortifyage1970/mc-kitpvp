# 首行无条件推进快照，漏写会每刻重复触发
scoreboard players operation @s kitpvp.taint_turret_last = @s kitpvp.taint_turret_used

execute if score @s kitpvp.cd matches ..0 run function kitpvp:skill/taint_archer/turret_fire
execute if score @s kitpvp.cd matches 1.. run title @s actionbar {"text":"炮台冷却中","color":"gray"}
