# 首行推进 fisher_last，漏写会无限连放；cd>0 时令牌已消耗但不放技能（设计接受的惩罚）
scoreboard players operation @s kitpvp.fisher_last = @s kitpvp.fisher_used

execute if score @s kitpvp.cd matches ..0 run function kitpvp:skill/fisher_fire
execute if score @s kitpvp.cd matches 1.. run title @s actionbar {"text":"寻戟冷却中","color":"gray"}
