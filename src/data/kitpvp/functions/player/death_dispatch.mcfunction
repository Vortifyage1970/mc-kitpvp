# 先推进 death_seen 再转 on_death，防止每刻重复触发
scoreboard players operation @s kitpvp.death_seen = @s kitpvp.death_detect
function kitpvp:player/on_death
