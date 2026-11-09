# 地球·81 电压门控钾通道：站桩型控制生灵，静息 → 去极化到阈值 → 开闸放钾 → 不应期
# 用尸壳当壳：1.20.1 里站桩的亡灵只有尸壳白天不烧（僵尸、流浪者、骷髅白天都会烧）
# 海晶灯当"通道孔"，NoAI + 移速 0 站桩；膜电位 kv_v / 状态 kv_state / 不应期 kv_ref 见 load.mcfunction
# 初始 -140：每刻 +1，涨到 -55 就开放（约 85 刻 = 4.3 秒）；被打一下额外 +8，可以催它提前开
# 一次只留一只：开新的时候把旧的清掉（同一个玩法坑，见飞行器）
kill @e[tag=kitpvp.earth_kv]
summon minecraft:husk ~ ~ ~ {Tags:["kitpvp.earth_minion","kitpvp.earth_minion_new","kitpvp.earth_kv"],CustomName:'{"text":"电压门控钾通道","color":"aqua"}',CustomNameVisible:1b,Silent:1b,NoAI:1b,PersistenceRequired:1b,CanPickUpLoot:0b,Health:30.0f,Attributes:[{Name:"minecraft:generic.max_health",Base:30.0},{Name:"minecraft:generic.movement_speed",Base:0}],HandItems:[{},{}],ArmorItems:[{id:"minecraft:leather_boots",Count:1b,tag:{display:{color:3355443}}},{id:"minecraft:leather_leggings",Count:1b,tag:{display:{color:3355443}}},{id:"minecraft:leather_chestplate",Count:1b,tag:{display:{color:3361970}}},{id:"minecraft:sea_lantern",Count:1b}]}
scoreboard players set @e[tag=kitpvp.earth_kv,limit=1,sort=nearest] kitpvp.kv_v -140
scoreboard players set @e[tag=kitpvp.earth_kv,limit=1,sort=nearest] kitpvp.kv_state 0
scoreboard players set @e[tag=kitpvp.earth_kv,limit=1,sort=nearest] kitpvp.kv_ref 0
