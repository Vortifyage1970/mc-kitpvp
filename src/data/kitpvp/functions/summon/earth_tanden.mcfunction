# 地球·68 串联体 tanden：两只僵尸，头都是末影箱；不用拴绳，靠 tick 的隐形牵引连在一起
# 牵引：tick 里 b 离 a 超过 3 格就 tp 回 a 身边 ⇒ 两只都保留完整 AI，都会主动追人
# 判定（每 3 秒、4 格内）：离玩家近的那只吃缓慢 II，远的那只吃速度 II（另一边的效果会被清掉）
# 一只死了：另一只永久获得速度 II + 力量 I（tanden_alone），并打上 kitpvp.tanden_alone 防重复
summon minecraft:zombie ~ ~ ~ {UUID:[I;1900003,1,1,1],Tags:["kitpvp.earth_minion","kitpvp.earth_minion_new","kitpvp.earth_tanden","kitpvp.earth_tanden_a"],CustomName:'{"text":"串联体","color":"dark_purple"}',CustomNameVisible:1b,PersistenceRequired:1b,CanPickUpLoot:0b,Silent:1b,Health:20.0f,Attributes:[{Name:"minecraft:generic.max_health",Base:20.0}],ArmorItems:[{},{},{},{id:"minecraft:ender_chest",Count:1b}]}
scoreboard players set @e[tag=kitpvp.earth_tanden_a] kitpvp.earth_cd_a 60
summon minecraft:zombie ~ ~ ~-1.5 {UUID:[I;1900003,2,1,1],Tags:["kitpvp.earth_minion","kitpvp.earth_minion_new","kitpvp.earth_tanden","kitpvp.earth_tanden_b"],CustomName:'{"text":"串联体","color":"dark_purple"}',CustomNameVisible:1b,PersistenceRequired:1b,CanPickUpLoot:0b,Silent:1b,Health:20.0f,Attributes:[{Name:"minecraft:generic.max_health",Base:20.0}],ArmorItems:[{},{},{},{id:"minecraft:ender_chest",Count:1b}]}
