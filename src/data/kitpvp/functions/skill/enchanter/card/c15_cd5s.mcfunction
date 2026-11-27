scoreboard players remove @s kitpvp.ench_domain_cd 160
execute if score @s kitpvp.ench_domain_cd matches ..0 run scoreboard players set @s kitpvp.ench_domain_cd 0
title @s actionbar [{"text":"◇ 抽到：","color":"aqua"},{"text":"蓄势","color":"aqua","bold":true},{"text":"（下次领域冷却 −8 秒）","color":"gray"}]
playsound minecraft:block.note_block.chime master @s ~ ~ ~ 0.7 1.3
