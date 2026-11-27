# 领域每刻：倒计时、发光、脚下金粒
scoreboard players remove @s kitpvp.ench_domain_t 1
effect give @s minecraft:glowing 2 0 true
particle minecraft:end_rod ~ ~0.2 ~ 0.5 0.1 0.5 0.01 2
title @s actionbar [{"text":"坐杀博徒 ","color":"light_purple"},{"score":{"name":"@s","objective":"kitpvp.ench_domain_t"},"color":"white"},{"text":" 刻 · 命中抽卡","color":"gray"}]
execute if score @s kitpvp.ench_domain_t matches ..0 run function kitpvp:skill/li_ench/end
