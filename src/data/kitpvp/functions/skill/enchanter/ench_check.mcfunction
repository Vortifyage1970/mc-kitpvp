# 任何来源加了蓄力之后都走这里：满了就升一级
# ench_wait：剑不在主手时挂上，避免每刻重复触发；剑回到手里由 tick 摘掉再重试
execute if score @s kitpvp.ench_ap matches 3.. run function kitpvp:skill/enchanter/up_armor
execute if score @s kitpvp.ench_sw matches 3.. unless entity @s[tag=kitpvp.ench_wait] run function kitpvp:skill/enchanter/up_sword
