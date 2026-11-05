# 铺一格细雪并挂 marker 计时（时长由调用方先设 #snow_time，单位刻）
# 调用方先设 #snow_time：术战士的剑 = 200 刻（流浪汉已不给细雪，以后再加用户照这个模式写）
# ★ 原版规则：着火的实体一碰到细雪，细雪立刻被拆掉、实体同时被灭火（Wiki: Powder Snow — Breaking）。
#   所以"这块雪刚铺就没"多半是被踩化，不是计时器出错；marker 还留着也没事，到点 snow_clear 会自己收尾。
summon minecraft:marker ~ ~ ~ {Tags:["kitpvp.earth_snow"]}
setblock ~ ~ ~ minecraft:powder_snow
scoreboard players operation @e[tag=kitpvp.earth_snow,distance=..1] kitpvp.earth_snow = #snow_time kitpvp.game
