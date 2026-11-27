# 右键「坐杀博徒·入场券」（蝙蝠蛋）：推进快照、清掉刷出来的蝙蝠，再判冷却开赌场
scoreboard players operation @s kitpvp.ench_domain_last = @s kitpvp.ench_domain_used
execute at @s run kill @e[type=minecraft:bat,distance=..8]
execute if entity @s[tag=kitpvp.ench_domain] run title @s actionbar {"text":"赌场已经开着了","color":"gray"}
execute unless entity @s[tag=kitpvp.ench_domain] if score @s kitpvp.ench_domain_ready matches 1.. run function kitpvp:skill/li_ench/start
execute unless entity @s[tag=kitpvp.ench_domain] if score @s kitpvp.ench_domain_ready matches ..0 if score @s kitpvp.ench_domain_cd matches ..0 run function kitpvp:skill/li_ench/start
execute unless entity @s[tag=kitpvp.ench_domain] if score @s kitpvp.ench_domain_ready matches ..0 if score @s kitpvp.ench_domain_cd matches 1.. run title @s actionbar [{"text":"坐杀博徒冷却中：","color":"gray"},{"score":{"name":"@s","objective":"kitpvp.ench_domain_cd"},"color":"white"},{"text":" 刻","color":"gray"}]
