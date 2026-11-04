# 铺一格细雪并挂 marker 计时（时长由调用方先设 #snow_time，单位刻）
# 调用方先设 #snow_time：术战士的剑 = 200 刻（流浪汉已不给细雪，以后再加用户照这个模式写）
summon minecraft:marker ~ ~ ~ {Tags:["kitpvp.earth_snow"]}
setblock ~ ~ ~ minecraft:powder_snow
scoreboard players operation @e[tag=kitpvp.earth_snow,distance=..1] kitpvp.earth_snow = #snow_time kitpvp.game
