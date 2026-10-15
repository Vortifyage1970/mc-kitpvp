# 首行无条件推进快照，漏写会每刻连发
scoreboard players operation @s kitpvp.tainted_fisher_blue_last = @s kitpvp.tainted_fisher_blue_used

# 打开"令牌发回"窗口：快照推进 = 令牌真的被用掉了（含"冷却中白按"，整把锁走完照样发回）
# ⚠ 不能用"背包里没有就补"当依据，那样拖动物品 / 丢地上都会凭空多出一个（见 04 §四）
tag @s add kitpvp.tainted_fisher_handout

# 两个技能共用一把锁：cd / cd2 任一不为 0 都不起手（放苍 → 两个都锁 60 秒；放领域展开 → 两个都锁 240 秒）
# 前摇期间 cd=30（由 blue_start 写入）也在这道闸门里，所以连按两次不会叠出两颗水球
execute if score @s kitpvp.cd matches ..0 if score @s kitpvp.cd2 matches ..0 unless entity @s[tag=kitpvp.tainted_fisher_cang] run function kitpvp:skill/tainted_fisher/blue_start

# cd>0 时令牌已消耗但技能不放（同表渔夫，设计接受的惩罚）；提示按"还剩哪把锁"给
execute if score @s kitpvp.cd2 matches 1.. run title @s actionbar {"text":"领域展开冷却中","color":"dark_aqua"}
execute if score @s kitpvp.cd2 matches ..0 if score @s kitpvp.cd matches 1.. run title @s actionbar {"text":"术式顺转·「苍」冷却中","color":"aqua"}
