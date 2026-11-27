# 2% 档：进入领域；已经在领域里就续 60 秒
execute if entity @s[tag=kitpvp.ench_domain] run scoreboard players set @s kitpvp.ench_domain_t 1200
execute if entity @s[tag=kitpvp.ench_domain] run title @s actionbar {"text":"坐杀博徒：续 60 秒","color":"light_purple"}
execute unless entity @s[tag=kitpvp.ench_domain] run function kitpvp:skill/li_ench/start
