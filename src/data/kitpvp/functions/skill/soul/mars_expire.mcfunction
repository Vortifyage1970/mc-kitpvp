# 20 秒到 / 巨人被打死：清巨人、停歌、摘标记
kill @e[tag=kitpvp.soul_mars_giant]
kill @e[tag=kitpvp.soul_mars_controller]
execute as @a run function kitpvp:music/rumbling/stop
function kitpvp:music/rumbling_lyric/stop

tag @s remove kitpvp.soul_mars_active
scoreboard players set @s kitpvp.soul_mars_timer 0

tellraw @a [{"text":"❖ ","color":"gold","bold":true},{"text":"地鸣停止了","color":"gray","italic":true}]
title @s actionbar {"text":"魂石·地鸣已消失","color":"gray"}
