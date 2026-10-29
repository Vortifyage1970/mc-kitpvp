# 整套同进同出：用掉一枚就收走其余两枚，并开始 30 秒（600 刻）补货计时
clear @s minecraft:zombie_spawn_egg{KitTtGroup1:1b}
clear @s minecraft:skeleton_spawn_egg{KitTtGroup1:1b}
clear @s minecraft:creeper_spawn_egg{KitTtGroup1:1b}
scoreboard players set @s kitpvp.cd 600
function kitpvp:skill/tainted_tamer/link
title @s actionbar {"text":"召唤完成（30 秒后补充整组）","color":"dark_red"}
playsound minecraft:entity.evoker.cast_spell master @s ~ ~ ~ 0.7 1.2
