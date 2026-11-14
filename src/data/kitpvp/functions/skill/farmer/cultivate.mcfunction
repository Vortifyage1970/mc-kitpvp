# 首行必须无条件推进快照，否则每刻重复触发（见 05 §三）
scoreboard players operation @s kitpvp.farm_last = @s kitpvp.farm_used
function kitpvp:skill/farmer/grow
