# 地球·32 流浪汉：40 血，头戴堆肥桶、身穿皮革胸甲；打中谁就往谁嘴里塞"口水"
# 打人判定不在 tick 里轮询，而是 advancements/player/vagrant_hit.json 的 source_entity 精确筛出"这个带 tag 的僵尸"
# ArmorItems 顺序是 [靴子, 护腿, 胸甲, 头盔]：堆肥桶是方块，戴头槽会正常渲染（发射器/砂轮/织布机都有先例）
summon minecraft:zombie ~ ~ ~ {Tags:["kitpvp.earth_vagrant","kitpvp.earth_minion","kitpvp.earth_minion_new"],CustomName:'{"text":"流浪汉","color":"dark_gray"}',CustomNameVisible:1b,PersistenceRequired:1b,CanPickUpLoot:0b,Health:40.0f,Attributes:[{Name:"minecraft:generic.max_health",Base:40.0}],ArmorItems:[{},{},{id:"minecraft:leather_chestplate",Count:1b},{id:"minecraft:composter",Count:1b}]}
