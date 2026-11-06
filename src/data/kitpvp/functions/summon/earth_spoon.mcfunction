# 地球·56 勺子：头戴铁块的僵尸，主手一把铁铲当大汤勺；打中人会把对方主手的物品"舀"到别的手持栏格子
# 本体没有额外伤害，威胁全在"你突然空手了"这一下（见 skill/earth/spoon_hit.mcfunction）
# 头槽放铁块 = 白天不自燃，也让它在人堆里一眼能认出来
summon minecraft:zombie ~ ~ ~ {Tags:["kitpvp.earth_minion","kitpvp.earth_minion_new","kitpvp.earth_spoon"],CustomName:'{"text":"勺子","color":"gray"}',CustomNameVisible:1b,PersistenceRequired:1b,CanPickUpLoot:0b,Health:20.0f,HandItems:[{id:"minecraft:iron_shovel",Count:1b},{}],ArmorItems:[{},{},{},{id:"minecraft:iron_block",Count:1b}]}
