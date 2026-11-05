# 地球·47 环肽（实验）：2 个氨基酸 + 2 条肽键围成半径 2 的圆圈，不靠骑乘 —— 原版做不到"骑成闭环"
# 排布由 skill/earth/ring_follow 每刻计算：整圈贴到最近的活玩家身上，所以它会跟着你走
# 旋转开关：#ring_spin=1 时每刻把四个方位轮换一格（看起来在绕圈）；=0 就是固定方位跟着你平移
# NoAI：不让它们自己乱走，位置完全由 tp 决定；血量和头饰与寡肽/多肽一致

summon minecraft:zombie ~ ~ ~ {id:"minecraft:zombie",Tags:["kitpvp.earth_minion","kitpvp.earth_minion_new","kitpvp.earth_cyclic","kitpvp.earth_ring_1"],Health:5.0f,Attributes:[{Name:"minecraft:generic.max_health",Base:5.0}],ArmorItems:[{},{},{},{id:"minecraft:smooth_stone",Count:1b}],NoAI:1b,Silent:1b,PersistenceRequired:1b,CanPickUpLoot:0b,CustomName:'{"text":"氨基酸","color":"green"}',CustomNameVisible:0b}
summon minecraft:silverfish ~ ~ ~ {id:"minecraft:silverfish",Tags:["kitpvp.earth_minion","kitpvp.earth_minion_new","kitpvp.earth_cyclic","kitpvp.earth_ring_2"],Health:1.0f,Attributes:[{Name:"minecraft:generic.max_health",Base:1.0}],NoAI:1b,Silent:1b,PersistenceRequired:1b,CanPickUpLoot:0b,CustomName:'{"text":"肽键","color":"aqua"}',CustomNameVisible:0b}
summon minecraft:zombie ~ ~ ~ {id:"minecraft:zombie",Tags:["kitpvp.earth_minion","kitpvp.earth_minion_new","kitpvp.earth_cyclic","kitpvp.earth_ring_3"],Health:5.0f,Attributes:[{Name:"minecraft:generic.max_health",Base:5.0}],ArmorItems:[{},{},{},{id:"minecraft:smooth_stone",Count:1b}],NoAI:1b,Silent:1b,PersistenceRequired:1b,CanPickUpLoot:0b,CustomName:'{"text":"氨基酸","color":"green"}',CustomNameVisible:0b}
summon minecraft:silverfish ~ ~ ~ {id:"minecraft:silverfish",Tags:["kitpvp.earth_minion","kitpvp.earth_minion_new","kitpvp.earth_cyclic","kitpvp.earth_ring_4"],Health:1.0f,Attributes:[{Name:"minecraft:generic.max_health",Base:1.0}],NoAI:1b,Silent:1b,PersistenceRequired:1b,CanPickUpLoot:0b,CustomName:'{"text":"肽键","color":"aqua"}',CustomNameVisible:0b}

# 关闭召唤播报的草地音（和无重力那批一致，这里干脆不响）
scoreboard players set #summon_quiet kitpvp.game 1

# 复位旋转状态：默认不转（想让它转就 /scoreboard players set #ring_spin kitpvp.game 1）
scoreboard players set #ring_spin kitpvp.game 0
scoreboard players set #ring_rot kitpvp.game 0
