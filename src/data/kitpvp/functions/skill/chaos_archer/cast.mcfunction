# 射出一箭后：装填下一支随机魔法箭（不再弹 actionbar）
scoreboard players operation @s kitpvp.archer_shot_last = @s kitpvp.archer_shot
function kitpvp:skill/chaos_archer/arrow
