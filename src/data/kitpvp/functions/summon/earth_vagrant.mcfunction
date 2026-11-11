# 地球·34 流浪汉：30 血，头戴堆肥桶、身穿皮革胸甲；谁打了它，就往谁嘴里塞一瓶"口水"
# 判定在 advancements/player/vagrant_spit.json：player_hurt_entity + entity.nbt 匹配 Tags:["kitpvp.earth_vagrant"]，rewards 直接以攻击者为 @s 执行 skill/earth/vagrant_spit —— 只有动手的那个人会中，站在旁边的不受影响
# ArmorItems 顺序是 [靴子, 护腿, 胸甲, 头盔]：堆肥桶是方块，戴头槽会正常渲染（发射器/砂轮/织布机都有先例）
summon minecraft:zombie ~ ~ ~ {Tags:["kitpvp.earth_vagrant","kitpvp.earth_minion","kitpvp.earth_minion_new"],CustomName:'{"text":"流浪汉","color":"dark_gray"}',CustomNameVisible:1b,PersistenceRequired:1b,CanPickUpLoot:0b,Health:30.0f,Attributes:[{Name:"minecraft:generic.max_health",Base:30.0}],ArmorItems:[{},{},{id:"minecraft:leather_chestplate",Count:1b},{id:"minecraft:composter",Count:1b}]}
