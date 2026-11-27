# 坐杀博徒：20 秒赌场时间（400 刻），冷却 50 秒（1000 刻）
scoreboard players set @s kitpvp.ench_domain_t 400
scoreboard players set @s kitpvp.ench_domain_cd 1000
scoreboard players set @s kitpvp.ench_domain_ready 0
tag @s add kitpvp.ench_domain
tellraw @a [{"text":"◆　","color":"light_purple"},{"text":"领域展开 · 坐杀博徒","color":"white","bold":true},{"text":"　◆","color":"light_purple"}]
execute as @a at @s run playsound minecraft:block.beacon.activate master @s ~ ~ ~ 0.7 1.0
execute as @a at @s run playsound minecraft:entity.vex.charge master @s ~ ~ ~ 0.5 0.8
particle minecraft:end_rod ~ ~1 ~ 2 2 2 0.1 120
title @s actionbar {"text":"坐杀博徒：20 秒，每次命中抽一张卡","color":"light_purple"}
