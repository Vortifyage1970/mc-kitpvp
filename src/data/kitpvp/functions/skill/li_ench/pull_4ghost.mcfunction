# 四星：召唤一只阴兵（走地球召唤的归属流程）
execute at @s run function kitpvp:summon/earth_ghost_minion
function kitpvp:skill/earth/link
title @s actionbar [{"text":"★★ 召唤阴兵","color":"aqua"}]
playsound minecraft:entity.evoker.prepare_summon master @s ~ ~ ~ 0.7 1.2
