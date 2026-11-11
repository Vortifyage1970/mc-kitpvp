# 地球·47 环肽（实验）：8 只氨基酸围成半径 2.5 的八边形，不靠骑乘 —— 原版做不到"骑成闭环"
# 圈心 = 召唤者（靠 earth_owner/etid 认人）；召唤者不在时退化成"离圈最近的活玩家"
# 旋转开关：#ring_spin=1（默认开）每 2 刻把十六个方位轮换一格（22.5°，一圈 32 刻）；改成 0 就是固定方位跟着人平移
# NoAI：不让它们自己乱走，位置完全由 tp 决定；1 血，头戴平滑石头

summon minecraft:zombie ~ ~ ~ {id:"minecraft:zombie",Silent:1b,Tags:["kitpvp.earth_minion","kitpvp.earth_minion_new","kitpvp.earth_cyclic","kitpvp.earth_ring_1"],Health:1.0f,Attributes:[{Name:"minecraft:generic.max_health",Base:1.0}],ArmorItems:[{},{},{},{id:"minecraft:smooth_stone",Count:1b}],CustomName:'{"text":"氨基酸","color":"green"}',CustomNameVisible:0b,PersistenceRequired:1b,CanPickUpLoot:0b,NoAI:1b}
summon minecraft:zombie ~ ~ ~ {id:"minecraft:zombie",Silent:1b,Tags:["kitpvp.earth_minion","kitpvp.earth_minion_new","kitpvp.earth_cyclic","kitpvp.earth_ring_2"],Health:1.0f,Attributes:[{Name:"minecraft:generic.max_health",Base:1.0}],ArmorItems:[{},{},{},{id:"minecraft:smooth_stone",Count:1b}],CustomName:'{"text":"氨基酸","color":"green"}',CustomNameVisible:0b,PersistenceRequired:1b,CanPickUpLoot:0b,NoAI:1b}
summon minecraft:zombie ~ ~ ~ {id:"minecraft:zombie",Silent:1b,Tags:["kitpvp.earth_minion","kitpvp.earth_minion_new","kitpvp.earth_cyclic","kitpvp.earth_ring_3"],Health:1.0f,Attributes:[{Name:"minecraft:generic.max_health",Base:1.0}],ArmorItems:[{},{},{},{id:"minecraft:smooth_stone",Count:1b}],CustomName:'{"text":"氨基酸","color":"green"}',CustomNameVisible:0b,PersistenceRequired:1b,CanPickUpLoot:0b,NoAI:1b}
summon minecraft:zombie ~ ~ ~ {id:"minecraft:zombie",Silent:1b,Tags:["kitpvp.earth_minion","kitpvp.earth_minion_new","kitpvp.earth_cyclic","kitpvp.earth_ring_4"],Health:1.0f,Attributes:[{Name:"minecraft:generic.max_health",Base:1.0}],ArmorItems:[{},{},{},{id:"minecraft:smooth_stone",Count:1b}],CustomName:'{"text":"氨基酸","color":"green"}',CustomNameVisible:0b,PersistenceRequired:1b,CanPickUpLoot:0b,NoAI:1b}
summon minecraft:zombie ~ ~ ~ {id:"minecraft:zombie",Silent:1b,Tags:["kitpvp.earth_minion","kitpvp.earth_minion_new","kitpvp.earth_cyclic","kitpvp.earth_ring_5"],Health:1.0f,Attributes:[{Name:"minecraft:generic.max_health",Base:1.0}],ArmorItems:[{},{},{},{id:"minecraft:smooth_stone",Count:1b}],CustomName:'{"text":"氨基酸","color":"green"}',CustomNameVisible:0b,PersistenceRequired:1b,CanPickUpLoot:0b,NoAI:1b}
summon minecraft:zombie ~ ~ ~ {id:"minecraft:zombie",Silent:1b,Tags:["kitpvp.earth_minion","kitpvp.earth_minion_new","kitpvp.earth_cyclic","kitpvp.earth_ring_6"],Health:1.0f,Attributes:[{Name:"minecraft:generic.max_health",Base:1.0}],ArmorItems:[{},{},{},{id:"minecraft:smooth_stone",Count:1b}],CustomName:'{"text":"氨基酸","color":"green"}',CustomNameVisible:0b,PersistenceRequired:1b,CanPickUpLoot:0b,NoAI:1b}
summon minecraft:zombie ~ ~ ~ {id:"minecraft:zombie",Silent:1b,Tags:["kitpvp.earth_minion","kitpvp.earth_minion_new","kitpvp.earth_cyclic","kitpvp.earth_ring_7"],Health:1.0f,Attributes:[{Name:"minecraft:generic.max_health",Base:1.0}],ArmorItems:[{},{},{},{id:"minecraft:smooth_stone",Count:1b}],CustomName:'{"text":"氨基酸","color":"green"}',CustomNameVisible:0b,PersistenceRequired:1b,CanPickUpLoot:0b,NoAI:1b}
summon minecraft:zombie ~ ~ ~ {id:"minecraft:zombie",Silent:1b,Tags:["kitpvp.earth_minion","kitpvp.earth_minion_new","kitpvp.earth_cyclic","kitpvp.earth_ring_8"],Health:1.0f,Attributes:[{Name:"minecraft:generic.max_health",Base:1.0}],ArmorItems:[{},{},{},{id:"minecraft:smooth_stone",Count:1b}],CustomName:'{"text":"氨基酸","color":"green"}',CustomNameVisible:0b,PersistenceRequired:1b,CanPickUpLoot:0b,NoAI:1b}

# 关闭召唤播报的草地音
scoreboard players set #summon_quiet kitpvp.game 1

# 复位旋转状态：默认转（想停就 /scoreboard players set #ring_spin kitpvp.game 0）
scoreboard players set #ring_spin kitpvp.game 1
scoreboard players set #ring_rot kitpvp.game 0
