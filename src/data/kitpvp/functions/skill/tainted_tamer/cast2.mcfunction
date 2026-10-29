# 技能组 2（cd2，60 秒）：卫道士 / 女巫 / 恼鬼 / 烈焰人，四枚蛋共用一套冷却（同 cast1）
execute if score @s kitpvp.ttamer_vindicator_used > @s kitpvp.ttamer_vindicator_last run function kitpvp:skill/tainted_tamer/spawn_vindicator
execute if score @s kitpvp.ttamer_witch_used > @s kitpvp.ttamer_witch_last run function kitpvp:skill/tainted_tamer/spawn_witch
execute if score @s kitpvp.ttamer_vex_used > @s kitpvp.ttamer_vex_last run function kitpvp:skill/tainted_tamer/spawn_vex
execute if score @s kitpvp.ttamer_blaze_used > @s kitpvp.ttamer_blaze_last run function kitpvp:skill/tainted_tamer/spawn_blaze

scoreboard players operation @s kitpvp.ttamer_vindicator_last = @s kitpvp.ttamer_vindicator_used
scoreboard players operation @s kitpvp.ttamer_witch_last = @s kitpvp.ttamer_witch_used
scoreboard players operation @s kitpvp.ttamer_vex_last = @s kitpvp.ttamer_vex_used
scoreboard players operation @s kitpvp.ttamer_blaze_last = @s kitpvp.ttamer_blaze_used
