# 整套同进同出：用掉一枚就收走其余三枚，并开始 60 秒（1200 刻）补货计时
clear @s minecraft:vindicator_spawn_egg{KitTtGroup2:1b}
clear @s minecraft:witch_spawn_egg{KitTtGroup2:1b}
clear @s minecraft:vex_spawn_egg{KitTtGroup2:1b}
clear @s minecraft:blaze_spawn_egg{KitTtGroup2:1b}
scoreboard players set @s kitpvp.cd2 1200
function kitpvp:skill/tainted_tamer/link
title @s actionbar {"text":"召唤完成（60 秒后补充整组）","color":"dark_red"}
playsound minecraft:entity.evoker.cast_spell master @s ~ ~ ~ 0.7 0.8
