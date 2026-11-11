# 地球·34 流浪汉：15 血，头戴堆肥桶、身穿皮革胸甲；它打了谁，就往谁嘴里塞一瓶"口水"
# 判定在 advancements/player/vagrant_spit.json：entity_hurt_player + damage.source_entity.nbt 匹配 Tags:["kitpvp.earth_vagrant"]，rewards 以挨打者为 @s 执行 skill/earth/vagrant_spit —— 只有真被它打中的那个人会中
# ArmorItems 顺序是 [靴子, 护腿, 胸甲, 头盔]：堆肥桶是方块，戴头槽会正常渲染（发射器/砂轮/织布机都有先例）
summon minecraft:zombie ~ ~ ~ {Tags:["kitpvp.earth_vagrant","kitpvp.earth_minion","kitpvp.earth_minion_new"],CustomName:'{"text":"流浪汉","color":"dark_gray"}',CustomNameVisible:1b,PersistenceRequired:1b,CanPickUpLoot:0b,Health:15.0f,Attributes:[{Name:"minecraft:generic.max_health",Base:15.0}],ArmorItems:[{},{},{id:"minecraft:leather_chestplate",Count:1b},{id:"minecraft:composter",Count:1b}]}
