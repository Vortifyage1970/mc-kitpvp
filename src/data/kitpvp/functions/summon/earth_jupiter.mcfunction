# 地球·35 木星：手拿火焰附加 I 的金剑、头戴橡木原木；倒下时在原地劈一道雷（结算在 skill/earth/jupiter_death）
# 原木当头盔会正常渲染（区块方块戴头槽有先例，见交警的磁石 / 术战士的哭泣黑曜石）
# 背上驮一个隐形 armor_stand（Marker:1b 无碰撞、Invisible 不渲染）当"死亡位置"锚点：
# 木星一死它就被放下来停在原地，tick 拿它的位置当落点劈雷 —— 不靠读血量，原因见 tick
summon minecraft:zombie ~ ~ ~ {Tags:["kitpvp.earth_minion","kitpvp.earth_minion_new","kitpvp.earth_jupiter"],CustomName:'{"text":"木星","color":"gold"}',CustomNameVisible:1b,PersistenceRequired:1b,CanPickUpLoot:0b,HandItems:[{id:"minecraft:golden_sword",Count:1b,tag:{Enchantments:[{id:"minecraft:fire_aspect",lvl:1}]}},{}],ArmorItems:[{},{},{},{id:"minecraft:oak_log",Count:1b}],Passengers:[{id:"minecraft:armor_stand",Tags:["kitpvp.earth_jupiter_anchor"],Invisible:1b,Marker:1b,NoGravity:1b}]}
