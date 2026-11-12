# 首行必须推进快照，漏写会无限连放（同 skill/fisher/cast）
scoreboard players operation @s kitpvp.chaos_skill_last = @s kitpvp.chaos_skill_used

execute if score @s kitpvp.cd matches ..0 run function kitpvp:kit/chaos_skill_do
execute if score @s kitpvp.cd matches 1.. run title @s actionbar {"text":"混沌·重铸冷却中","color":"gray"}
