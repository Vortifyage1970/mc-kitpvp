# 地球·79 土星：装备与弓箭手同款（皮革胸甲 + 铁腿 + 铁靴，白板弓），头是泥砖
# 身边一圈 8 只「轨道」蠹虫——不落地、不吃重力，靠 saturn_tick 按 8 个位置绕圈
# 不吃击退：knockback_resistance 1.0（和炮台一样）
summon minecraft:skeleton ~ ~ ~ {Tags:["kitpvp.earth_minion","kitpvp.earth_minion_new","kitpvp.earth_saturn"],CustomName:'{"text":"土星","color":"gold"}',CustomNameVisible:1b,Silent:1b,PersistenceRequired:1b,CanPickUpLoot:0b,Health:20.0f,Attributes:[{Name:"minecraft:generic.max_health",Base:20.0},{Name:"minecraft:generic.knockback_resistance",Base:1.0}],ArmorItems:[{id:"minecraft:iron_boots",Count:1b},{id:"minecraft:iron_leggings",Count:1b},{id:"minecraft:leather_chestplate",Count:1b},{id:"minecraft:mud_bricks",Count:1b}],HandItems:[{id:"minecraft:bow",Count:1b},{}]}

# 八条轨道：每只召出来先打 sat_new，谁身上还挂着 sat_new 就只有它一只，相位就不会点错人
kill @e[tag=kitpvp.sat_orbit,distance=..6]
summon minecraft:silverfish ~2.2 ~0.9 ~ {Tags:["kitpvp.earth_minion","kitpvp.sat_orbit","kitpvp.sat_new"],CustomName:'{"text":"轨道","color":"gray"}',CustomNameVisible:1b,Silent:1b,NoAI:1b,NoGravity:1b,PersistenceRequired:1b,Health:1.0f,Attributes:[{Name:"minecraft:generic.max_health",Base:1.0}]}
scoreboard players set @e[tag=kitpvp.sat_new,limit=1] kitpvp.sat_phase 0
tag @e[tag=kitpvp.sat_new] remove kitpvp.sat_new
summon minecraft:silverfish ~1.56 ~1.0 ~1.56 {Tags:["kitpvp.earth_minion","kitpvp.sat_orbit","kitpvp.sat_new"],CustomName:'{"text":"轨道","color":"gray"}',CustomNameVisible:1b,Silent:1b,NoAI:1b,NoGravity:1b,PersistenceRequired:1b,Health:1.0f,Attributes:[{Name:"minecraft:generic.max_health",Base:1.0}]}
scoreboard players set @e[tag=kitpvp.sat_new,limit=1] kitpvp.sat_phase 1
tag @e[tag=kitpvp.sat_new] remove kitpvp.sat_new
summon minecraft:silverfish ~0 ~1.1 ~2.2 {Tags:["kitpvp.earth_minion","kitpvp.sat_orbit","kitpvp.sat_new"],CustomName:'{"text":"轨道","color":"gray"}',CustomNameVisible:1b,Silent:1b,NoAI:1b,NoGravity:1b,PersistenceRequired:1b,Health:1.0f,Attributes:[{Name:"minecraft:generic.max_health",Base:1.0}]}
scoreboard players set @e[tag=kitpvp.sat_new,limit=1] kitpvp.sat_phase 2
tag @e[tag=kitpvp.sat_new] remove kitpvp.sat_new
summon minecraft:silverfish ~-1.56 ~1.0 ~1.56 {Tags:["kitpvp.earth_minion","kitpvp.sat_orbit","kitpvp.sat_new"],CustomName:'{"text":"轨道","color":"gray"}',CustomNameVisible:1b,Silent:1b,NoAI:1b,NoGravity:1b,PersistenceRequired:1b,Health:1.0f,Attributes:[{Name:"minecraft:generic.max_health",Base:1.0}]}
scoreboard players set @e[tag=kitpvp.sat_new,limit=1] kitpvp.sat_phase 3
tag @e[tag=kitpvp.sat_new] remove kitpvp.sat_new
summon minecraft:silverfish ~-2.2 ~0.9 ~ {Tags:["kitpvp.earth_minion","kitpvp.sat_orbit","kitpvp.sat_new"],CustomName:'{"text":"轨道","color":"gray"}',CustomNameVisible:1b,Silent:1b,NoAI:1b,NoGravity:1b,PersistenceRequired:1b,Health:1.0f,Attributes:[{Name:"minecraft:generic.max_health",Base:1.0}]}
scoreboard players set @e[tag=kitpvp.sat_new,limit=1] kitpvp.sat_phase 4
tag @e[tag=kitpvp.sat_new] remove kitpvp.sat_new
summon minecraft:silverfish ~-1.56 ~0.8 ~-1.56 {Tags:["kitpvp.earth_minion","kitpvp.sat_orbit","kitpvp.sat_new"],CustomName:'{"text":"轨道","color":"gray"}',CustomNameVisible:1b,Silent:1b,NoAI:1b,NoGravity:1b,PersistenceRequired:1b,Health:1.0f,Attributes:[{Name:"minecraft:generic.max_health",Base:1.0}]}
scoreboard players set @e[tag=kitpvp.sat_new,limit=1] kitpvp.sat_phase 5
tag @e[tag=kitpvp.sat_new] remove kitpvp.sat_new
summon minecraft:silverfish ~0 ~0.7 ~-2.2 {Tags:["kitpvp.earth_minion","kitpvp.sat_orbit","kitpvp.sat_new"],CustomName:'{"text":"轨道","color":"gray"}',CustomNameVisible:1b,Silent:1b,NoAI:1b,NoGravity:1b,PersistenceRequired:1b,Health:1.0f,Attributes:[{Name:"minecraft:generic.max_health",Base:1.0}]}
scoreboard players set @e[tag=kitpvp.sat_new,limit=1] kitpvp.sat_phase 6
tag @e[tag=kitpvp.sat_new] remove kitpvp.sat_new
summon minecraft:silverfish ~1.56 ~0.8 ~-1.56 {Tags:["kitpvp.earth_minion","kitpvp.sat_orbit","kitpvp.sat_new"],CustomName:'{"text":"轨道","color":"gray"}',CustomNameVisible:1b,Silent:1b,NoAI:1b,NoGravity:1b,PersistenceRequired:1b,Health:1.0f,Attributes:[{Name:"minecraft:generic.max_health",Base:1.0}]}
scoreboard players set @e[tag=kitpvp.sat_new,limit=1] kitpvp.sat_phase 7
tag @e[tag=kitpvp.sat_new] remove kitpvp.sat_new

# 轨道给抗性 V（amplifier 4）：1 血也不会被一发箭点掉，只能靠真伤/掉落慢慢磨
effect give @e[tag=kitpvp.sat_orbit,distance=..6] minecraft:resistance infinite 4 true
