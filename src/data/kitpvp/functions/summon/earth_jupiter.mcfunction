# 地球·35 木星：手拿火焰附加 I 的金剑、头戴橡木原木；倒下时在原地劈一道雷（结算在 skill/earth/jupiter_death）
# 原木当头盔会正常渲染（区块方块戴头槽有先例，见交警的磁石 / 术战士的哭泣黑曜石）
# 劈雷靠 tick 抓"尸体 Health=0"那一帧，本体身上不驮东西 —— 原因写在 tick 那段注释里
summon minecraft:zombie ~ ~ ~ {Tags:["kitpvp.earth_minion","kitpvp.earth_minion_new","kitpvp.earth_jupiter"],CustomName:'{"text":"木星","color":"gold"}',CustomNameVisible:1b,PersistenceRequired:1b,CanPickUpLoot:0b,HandItems:[{id:"minecraft:golden_sword",Count:1b,tag:{Enchantments:[{id:"minecraft:fire_aspect",lvl:1}]}},{}],ArmorItems:[{},{},{},{id:"minecraft:oak_log",Count:1b}]}
