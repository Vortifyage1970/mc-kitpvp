# 首行无条件推进快照，漏写会每刻连发
scoreboard players operation @s kitpvp.venus_bomb_last = @s kitpvp.venus_bomb_used

kill @e[type=minecraft:silverfish,tag=kitpvp.venus_token,distance=..16]

execute if score @s kitpvp.venus_cd3 matches ..0 run function kitpvp:skill/venus/bomb_fire
execute if score @s kitpvp.venus_cd3 matches 1.. run title @s actionbar {"text":"自爆模块冷却中","color":"gold"}
