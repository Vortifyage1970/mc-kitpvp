# 射出一箭后：装填下一支随机魔法箭（同 1.12.2 的 bow 统计 + 随机箭表）
scoreboard players operation @s kitpvp.archer_shot_last = @s kitpvp.archer_shot
function kitpvp:skill/chaos_archer/arrow
title @s actionbar {"text":"魔法箭装填","color":"light_purple"}
