# 地球·47 赢家：出场的那一瞬间，把「游戏结束 / 胜者：Chincken_brothers 赢了！」整套结算播报原样打一遍
# 文案与音效照抄 game/end.mcfunction 的胜利分支，只把胜者名字写死成 Chincken_brothers（那位玩家赢下的效果）
# 名字能不能显示取决于名字里有没有特殊字符；这里用 tellraw 的普通文本，不走 selector，所以不依赖玩家在线
title @a times 10 60 20
title @a title {"text":"游戏结束","color":"gold","bold":true}
title @a subtitle [{"text":"胜者：","color":"yellow"},{"text":"Chincken_brothers","color":"white","bold":true}]
tellraw @a [{"text":"[胜利]","color":"gold","bold":true},{"text":"Chincken_brothers","color":"yellow"},{"text":" 赢了！","color":"yellow"}]
execute as @a run playsound minecraft:ui.toast.challenge_complete master @s ~ ~ ~ 1 1

# 本体：金头盔当王冠的僵尸，20 血；不抢东西、不消失
summon minecraft:zombie ~ ~ ~ {Tags:["kitpvp.earth_minion","kitpvp.earth_minion_new","kitpvp.earth_winner"],CustomName:'{"text":"赢家","color":"gold"}',CustomNameVisible:0b,PersistenceRequired:1b,CanPickUpLoot:0b,Health:20.0f,Attributes:[{Name:"minecraft:generic.max_health",Base:20.0}],ArmorItems:[{},{},{},{id:"minecraft:golden_helmet",Count:1b}]}
