# 地球·56 勺子：头戴白桦木的骷髅，主手一把铁铲当大汤勺
# 打中人时 60% 概率把对方主手的物品塞进背包（27 格全满则打掉在地上）——见 skill/earth/spoon_hit.mcfunction
# 头槽放白桦木：骨头白天会烧，戴上头块就不烧了；也让人一眼认出"那个木头脑袋"
# 骷髅会射箭：箭伤同样能触发（挨打那一帧判定），所以它站着不动也可能把你的武器抢走
summon minecraft:skeleton ~ ~ ~ {Tags:["kitpvp.earth_minion","kitpvp.earth_minion_new","kitpvp.earth_spoon"],CustomName:'{"text":"勺子","color":"gray"}',CustomNameVisible:1b,PersistenceRequired:1b,CanPickUpLoot:0b,Health:15.0f,Attributes:[{Name:"minecraft:generic.max_health",Base:15.0}],HandItems:[{id:"minecraft:iron_shovel",Count:1b},{}],ArmorItems:[{},{},{},{id:"minecraft:birch_wood",Count:1b}]}
