# 领域每刻：倒计时、维持三条 buff、每 40 刻白抽一次
scoreboard players remove @s kitpvp.ench_domain_t 1
effect give @s minecraft:speed 3 1 true
effect give @s minecraft:haste 3 1 true
effect give @s minecraft:regeneration 3 0 true
execute if score @s kitpvp.li_dom_pull matches 1.. run scoreboard players remove @s kitpvp.li_dom_pull 1
execute if score @s kitpvp.li_dom_pull matches ..0 run function kitpvp:skill/li_ench/dom_pull
particle minecraft:end_rod ~ ~0.2 ~ 0.5 0.1 0.5 0.01 2
scoreboard players operation #li_sec kitpvp.game = @s kitpvp.ench_domain_t
scoreboard players operation #li_sec kitpvp.game /= #li_twenty kitpvp.game
title @s actionbar [{"text":"坐杀博徒 ","color":"light_purple"},{"score":{"name":"#li_sec","objective":"kitpvp.game"},"color":"white"},{"text":" 秒","color":"gray"}]
execute if score @s kitpvp.ench_domain_t matches ..0 run function kitpvp:skill/li_ench/end
