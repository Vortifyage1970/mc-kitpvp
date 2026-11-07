# 地球·37 木星：手拿火焰附加 I 的金剑、头戴橡木原木；倒下时在原地劈一道雷（结算在 skill/earth/jupiter_death）
# 原木当头盔会正常渲染（区块方块戴头槽有先例，见交警的磁石 / 术战士的哭泣黑曜石）
# 劈雷：脚下同时埋一个隐形 marker 当"守卫"，每刻被 tick 拖到木星身上（见 tick 那段注释）
summon minecraft:zombie ~ ~ ~ {Tags:["kitpvp.earth_minion","kitpvp.earth_minion_new","kitpvp.earth_jupiter"],CustomName:'{"text":"木星","color":"gold"}',CustomNameVisible:1b,PersistenceRequired:1b,CanPickUpLoot:0b,Health:12.0f,Attributes:[{Name:"minecraft:generic.max_health",Base:12.0}],HandItems:[{id:"minecraft:golden_sword",Count:1b,tag:{Enchantments:[{id:"minecraft:fire_aspect",lvl:1}]}},{}],ArmorItems:[{},{},{},{id:"minecraft:oak_log",Count:1b}]}
summon minecraft:marker ~ ~ ~ {Tags:["kitpvp.earth_jupiter_guard"]}
