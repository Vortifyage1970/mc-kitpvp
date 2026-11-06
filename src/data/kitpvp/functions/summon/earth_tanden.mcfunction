# 地球·68 串联体 tanden：两只僵尸，头都是末影箱，后面那只用拴绳连在前面那只身上
# 常驻加速：前面那只（_a）速度 II，后面被拴的那只（_b）速度 III —— 被拴的生物导航范围受绳子限制，快一点才跟得上
# 机制：每 3 秒判一次，离玩家更近的那只吃缓慢 III（另一只清掉），谁往前站谁被拖慢
summon minecraft:zombie ~ ~ ~ {UUID:[I;1900003,1,1,1],Tags:["kitpvp.earth_minion","kitpvp.earth_minion_new","kitpvp.earth_tanden","kitpvp.earth_tanden_a"],CustomName:'{"text":"串联体","color":"dark_purple"}',CustomNameVisible:1b,PersistenceRequired:1b,CanPickUpLoot:0b,Silent:1b,Health:20.0f,Attributes:[{Name:"minecraft:generic.max_health",Base:20.0}],ArmorItems:[{},{},{},{id:"minecraft:ender_chest",Count:1b}]}
scoreboard players set @e[tag=kitpvp.earth_tanden_a] kitpvp.earth_cd_a 60
summon minecraft:zombie ~ ~ ~-1.5 {UUID:[I;1900003,2,1,1],Leash:{UUID:[I;1900003,1,1,1]},Tags:["kitpvp.earth_minion","kitpvp.earth_minion_new","kitpvp.earth_tanden","kitpvp.earth_tanden_b"],CustomName:'{"text":"串联体","color":"dark_purple"}',CustomNameVisible:1b,PersistenceRequired:1b,CanPickUpLoot:0b,Silent:1b,Health:20.0f,Attributes:[{Name:"minecraft:generic.max_health",Base:20.0}],ArmorItems:[{},{},{},{id:"minecraft:ender_chest",Count:1b}]}
effect give @e[tag=kitpvp.earth_tanden_a] minecraft:speed infinite 1 true
effect give @e[tag=kitpvp.earth_tanden_b] minecraft:speed infinite 2 true
