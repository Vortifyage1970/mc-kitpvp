# 每刻：剑一到主手就把排队的附魔补上（每刻补一次）
execute if score @s kitpvp.ench_pending matches 1.. if data entity @s SelectedItem{id:"minecraft:golden_sword"} run function kitpvp:skill/enchanter/sw_pending_one
