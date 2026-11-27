# 里·附魔师每刻：冷却递减、领域 tick、临时强化计时、赌徒之蛋派发
execute if score @s kitpvp.ench_domain_cd matches 1.. run scoreboard players remove @s kitpvp.ench_domain_cd 1
execute if entity @s[tag=kitpvp.ench_domain] run function kitpvp:skill/li_ench/tick_domain
execute if score @s kitpvp.ench_tmp matches 1.. run scoreboard players remove @s kitpvp.ench_tmp 1
execute if score @s kitpvp.ench_tmp matches ..0 if score @s kitpvp.ench_tmp_kind matches 1.. run function kitpvp:skill/li_ench/tmp_expire
execute if score @s kitpvp.ench_egg_used > @s kitpvp.ench_egg_last run function kitpvp:skill/li_ench/redraw
execute if score @s kitpvp.ench_domain_used > @s kitpvp.ench_domain_last run function kitpvp:skill/li_ench/cast
