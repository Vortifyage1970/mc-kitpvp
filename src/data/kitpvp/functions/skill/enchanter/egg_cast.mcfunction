# 赌徒之蛋：右键 → 下一次领域不吃冷却（不立刻展开，还是要右键书）
scoreboard players operation @s kitpvp.ench_egg_last = @s kitpvp.ench_egg_used
execute at @s run kill @e[type=minecraft:turtle,distance=..8]
scoreboard players set @s kitpvp.ench_domain_ready 1
title @s actionbar {"text":"赌徒之蛋已使用：下一次领域不消耗冷却","color":"light_purple"}
playsound minecraft:block.note_block.chime master @s ~ ~ ~ 0.9 1.6
