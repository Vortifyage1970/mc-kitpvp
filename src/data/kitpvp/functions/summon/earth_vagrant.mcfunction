# 地球·32 流浪汉：40 血，头戴堆肥桶、身穿皮革胸甲；打中谁就往谁嘴里塞"口水"
# 打人判定在 tick.mcfunction:272（挨打那一帧 + 3 格内有流浪汉）→ skill/earth/vagrant_hit；不用 advancement，那套条件在这个版本上没触发过
# ArmorItems 顺序是 [靴子, 护腿, 胸甲, 头盔]：堆肥桶是方块，戴头槽会正常渲染（发射器/砂轮/织布机都有先例）
summon minecraft:zombie ~ ~ ~ {Tags:["kitpvp.earth_vagrant","kitpvp.earth_minion","kitpvp.earth_minion_new"],CustomName:'{"text":"流浪汉","color":"dark_gray"}',CustomNameVisible:1b,PersistenceRequired:1b,CanPickUpLoot:0b,Health:40.0f,Attributes:[{Name:"minecraft:generic.max_health",Base:40.0}],ArmorItems:[{},{},{id:"minecraft:leather_chestplate",Count:1b},{id:"minecraft:composter",Count:1b}]}
