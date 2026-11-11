# @s = 滑冰者：每刻由 tick 调一次，两个计时在这里各自判断（省掉两遍 @e 过滤）
# 铺雪：earth_cd_a 到点就铺一格并重置 5 刻；音效：skater_snd 每刻减 1，到 0 放一声并重置 40 刻
execute if score @s kitpvp.earth_cd_a matches ..0 run function kitpvp:skill/earth/skater_ice
execute if score @s kitpvp.skater_snd matches 1.. run scoreboard players remove @s kitpvp.skater_snd 1
execute if score @s kitpvp.skater_snd matches ..0 run function kitpvp:skill/earth/skater_skate
