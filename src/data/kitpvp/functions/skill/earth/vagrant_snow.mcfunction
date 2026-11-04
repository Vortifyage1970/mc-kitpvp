# 口水糊脸：1.20.1 没有"冰冻"这个状态效果，想让人吃到细雪那套冰冻表现（屏幕结霜 + 冻裂的心 + 缓慢）
# 只能真的把人塞进细雪里。所以这里在受害者脚下铺一格细雪，挂一个 marker 计时 100 刻（5 秒）后收回
summon minecraft:marker ~ ~ ~ {Tags:["kitpvp.earth_snow"]}
setblock ~ ~ ~ minecraft:powder_snow
scoreboard players set @e[tag=kitpvp.earth_snow,distance=..1] kitpvp.earth_snow 100
