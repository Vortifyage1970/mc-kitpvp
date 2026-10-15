# 首行推进快照，漏写会每刻连发
scoreboard players operation @s kitpvp.tainted_fisher_blue_last = @s kitpvp.tainted_fisher_blue_used

# 开"令牌发回"窗口：快照推进 = 令牌真的被用掉。不用"背包里没有就补"，否则拖动物品也会多给（04 §四）
tag @s add kitpvp.tainted_fisher_handout

# 两技能共用一把锁：cd / cd2 任一不为 0 都不起手（前摇期间 cd=30 / cd2=20 也在这道闸门里）
execute if score @s kitpvp.cd matches ..0 if score @s kitpvp.cd2 matches ..0 unless entity @s[tag=kitpvp.tainted_fisher_cang] run function kitpvp:skill/tainted_fisher/blue_start

# 冷却中按了只提示、不放技能
execute if score @s kitpvp.cd2 matches 1.. run title @s actionbar {"text":"领域展开冷却中","color":"dark_aqua"}
execute if score @s kitpvp.cd2 matches ..0 if score @s kitpvp.cd matches 1.. run title @s actionbar {"text":"术式顺转·「苍」冷却中","color":"aqua"}
