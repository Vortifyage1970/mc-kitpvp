# 地球·48 赢家：出场的那一瞬间，把「游戏结束 / 胜者：Chicken_brothers 赢了！」整套结算播报原样打一遍
# 文案与音效照抄 game/end.mcfunction 的胜利分支，只把胜者名字写死成 Chicken_brothers（那位玩家赢下的效果）
# 名字能不能显示取决于名字里有没有特殊字符；这里用 tellraw 的普通文本，不走 selector，所以不依赖玩家在线
# 召唤者本人不收到这套假结算（他用道具召出来自己不该被判"你赢了"）：召唤瞬间记一个记号
scoreboard players set @a kitpvp.winner_summoner 0
scoreboard players set @s kitpvp.winner_summoner 1
title @a[scores={kitpvp.winner_summoner=0}] times 10 60 20
title @a[scores={kitpvp.winner_summoner=0}] title {"text":"游戏结束","color":"gold","bold":true}
title @a[scores={kitpvp.winner_summoner=0}] subtitle [{"text":"胜者：","color":"yellow"},{"text":"Chicken_brothers","color":"white","bold":true}]
tellraw @a[scores={kitpvp.winner_summoner=0}] [{"text":"[胜利]","color":"gold","bold":true},{"text":"Chicken_brothers","color":"yellow"},{"text":" 赢了！","color":"yellow"}]
execute as @a[scores={kitpvp.winner_summoner=0}] run playsound minecraft:ui.toast.challenge_complete master @s ~ ~ ~ 1 1

# 本体：头顶黄色带釉陶瓦当王冠、双手各举一支附魔（耐久 I，只为发光）的向日葵，20 血；不抢东西、不消失
summon minecraft:zombie ~ ~ ~ {Tags:["kitpvp.earth_minion","kitpvp.earth_minion_new","kitpvp.earth_winner"],CustomName:'{"text":"赢家","color":"gold"}',CustomNameVisible:0b,PersistenceRequired:1b,CanPickUpLoot:0b,Health:20.0f,Attributes:[{Name:"minecraft:generic.max_health",Base:20.0}],HandItems:[{id:"minecraft:sunflower",Count:1b,tag:{Enchantments:[{id:"minecraft:unbreaking",lvl:1},{id:"minecraft:sharpness",lvl:3s}]}},{id:"minecraft:sunflower",Count:1b,tag:{Enchantments:[{id:"minecraft:unbreaking",lvl:1},{id:"minecraft:sharpness",lvl:3s}]}}],ArmorItems:[{},{},{},{id:"minecraft:yellow_glazed_terracotta",Count:1b}]}
