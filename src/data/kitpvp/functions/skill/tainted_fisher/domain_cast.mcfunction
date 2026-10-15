# 首行无条件推进快照，漏写会每刻连发
scoreboard players operation @s kitpvp.tainted_fisher_domain_last = @s kitpvp.tainted_fisher_domain_used

# 打开"令牌发回"窗口（同 blue_cast），两个技能共用这一个 tag
tag @s add kitpvp.tainted_fisher_handout

# 与「苍」共用一把锁（同 blue_cast）；前摇期间 cd2=20（由 domain_start 写入）也在这道闸门里
execute if score @s kitpvp.cd matches ..0 if score @s kitpvp.cd2 matches ..0 unless entity @s[tag=kitpvp.tainted_fisher_domain] run function kitpvp:skill/tainted_fisher/domain_start

execute if score @s kitpvp.cd2 matches 1.. run title @s actionbar {"text":"领域展开冷却中","color":"dark_aqua"}
execute if score @s kitpvp.cd2 matches ..0 if score @s kitpvp.cd matches 1.. run title @s actionbar {"text":"术式顺转·「苍」冷却中","color":"aqua"}
