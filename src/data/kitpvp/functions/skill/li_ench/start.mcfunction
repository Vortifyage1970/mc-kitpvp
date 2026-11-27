# 坐杀博徒：60 秒（1200 刻）；速度 II / 急迫 II / 生命回复 I；每 2 秒白抽一次
scoreboard players set @s kitpvp.ench_domain_t 1200
scoreboard players set @s kitpvp.ench_domain_cd 1200
scoreboard players set @s kitpvp.li_dom_pull 40
tag @s add kitpvp.ench_domain
effect give @s minecraft:speed 1200 1 true
effect give @s minecraft:haste 1200 1 true
effect give @s minecraft:regeneration 1200 0 true
tellraw @a [{"text":"◤　","color":"light_purple"},{"text":"领域展开 ・ 坐杀博徒","color":"white","bold":true},{"text":"　◢","color":"light_purple"}]
execute as @a at @s run playsound minecraft:block.beacon.activate master @s ~ ~ ~ 0.7 1.0
particle minecraft:end_rod ~ ~1 ~ 2 2 2 0.1 120
title @s actionbar {"text":"坐杀博徒：60 秒，每 2 秒白抽一次","color":"light_purple"}
