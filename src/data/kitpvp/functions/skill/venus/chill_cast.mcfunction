# 首行无条件推进快照，漏写会每刻连发
scoreboard players operation @s kitpvp.venus_chill_last = @s kitpvp.venus_chill_used

# 蛋一用就会刷出基础生物（北极熊），当场清掉，只认本职业的 EntityTag
kill @e[type=minecraft:polar_bear,tag=kitpvp.venus_token,distance=..16]

execute if score @s kitpvp.cd matches ..0 run function kitpvp:skill/venus/chill_fire
execute if score @s kitpvp.cd matches 1.. run title @s actionbar {"text":"制冷模块冷却中","color":"aqua"}
