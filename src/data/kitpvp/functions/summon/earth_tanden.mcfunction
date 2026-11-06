# 地球·68 串联体 tanden：一只僵尸 + 一只骷髅，头都是末影箱，骷髅用拴绳连在僵尸身上
# 机制：谁离玩家更近，谁就吃缓慢 III（按"每一对"算，一对里只会有一节被减速）
# 骷髅空手：不给弓它就不射箭（纯当"拖后腿的那一节"用）
summon minecraft:zombie ~ ~ ~ {UUID:[I;1900003,1,1,1],Tags:["kitpvp.earth_minion","kitpvp.earth_minion_new","kitpvp.earth_tanden","kitpvp.earth_tanden_a"],CustomName:'{"text":"串联体","color":"dark_purple"}',CustomNameVisible:1b,PersistenceRequired:1b,CanPickUpLoot:0b,Silent:1b,Health:20.0f,Attributes:[{Name:"minecraft:generic.max_health",Base:20.0}],ArmorItems:[{},{},{},{id:"minecraft:ender_chest",Count:1b}]}
scoreboard players set @e[tag=kitpvp.earth_tanden_a] kitpvp.earth_cd_a 60
summon minecraft:skeleton ~ ~ ~-1.5 {UUID:[I;1900003,2,1,1],Leash:{UUID:[I;1900003,1,1,1]},Tags:["kitpvp.earth_minion","kitpvp.earth_minion_new","kitpvp.earth_tanden","kitpvp.earth_tanden_b"],CustomName:'{"text":"串联体","color":"dark_purple"}',CustomNameVisible:1b,PersistenceRequired:1b,CanPickUpLoot:0b,Silent:1b,Health:20.0f,Attributes:[{Name:"minecraft:generic.max_health",Base:20.0}],ArmorItems:[{},{},{},{id:"minecraft:ender_chest",Count:1b}]}
