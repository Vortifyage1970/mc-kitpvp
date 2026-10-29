# 首行无条件推进快照，漏写会每刻连发
scoreboard players operation @s kitpvp.civil_demon_last = @s kitpvp.civil_demon_used

kill @e[type=minecraft:strider,tag=kitpvp.civil_token,distance=..16]

execute if score @s kitpvp.cd2 matches ..0 run function kitpvp:skill/civil/demon_start
execute if score @s kitpvp.cd2 matches 1.. run title @s actionbar {"text":"恶魔形态冷却中","color":"dark_red"}
