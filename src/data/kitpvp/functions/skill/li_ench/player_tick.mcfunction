# 里·附魔师每刻：冷却、蛋派发、领域、临时强化
execute if score @s kitpvp.li_single_cd matches 1.. run scoreboard players remove @s kitpvp.li_single_cd 1
execute if score @s kitpvp.li_ten_cd matches 1.. run scoreboard players remove @s kitpvp.li_ten_cd 1
execute if score @s kitpvp.li_single_used > @s kitpvp.li_single_last run function kitpvp:skill/li_ench/single_use
execute if score @s kitpvp.li_ten_used > @s kitpvp.li_ten_last run function kitpvp:skill/li_ench/ten_use
execute if score @s kitpvp.ench_domain_cd matches 1.. run scoreboard players remove @s kitpvp.ench_domain_cd 1
execute if entity @s[tag=kitpvp.ench_domain] run function kitpvp:skill/li_ench/tick_domain
execute if score @s kitpvp.ench_tmp matches 1.. run scoreboard players remove @s kitpvp.ench_tmp 1
execute if score @s kitpvp.ench_tmp matches ..0 if score @s kitpvp.ench_tmp_kind matches 1.. run function kitpvp:skill/li_ench/tmp_expire
