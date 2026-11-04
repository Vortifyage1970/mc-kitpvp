# 铺一格细雪并挂 marker 计时（时长由调用方先设 #snow_time，单位刻）
# 流浪汉口水 = 100 刻、术战士的剑 = 140 刻，两边共用这一段，别各写一份
summon minecraft:marker ~ ~ ~ {Tags:["kitpvp.earth_snow"]}
setblock ~ ~ ~ minecraft:powder_snow
scoreboard players operation @e[tag=kitpvp.earth_snow,distance=..1] kitpvp.earth_snow = #snow_time kitpvp.game
