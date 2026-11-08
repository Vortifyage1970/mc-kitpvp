# 地球·79 土星：装备与炮台同款（铁甲 + 力量 I/Punch I 的弓），头是泥砖
# 身边一圈「轨道」蠹虫——不落地、不吃重力，靠 saturn_tick 按 8 个位置绕圈
# 不吃击退：knockback_resistance 1.0（和炮台一样）
summon minecraft:skeleton ~ ~ ~ {Tags:["kitpvp.earth_minion","kitpvp.earth_minion_new","kitpvp.earth_saturn"],CustomName:'{"text":"土星","color":"gold"}',CustomNameVisible:1b,Silent:1b,PersistenceRequired:1b,CanPickUpLoot:0b,Health:20.0f,Attributes:[{Name:"minecraft:generic.max_health",Base:20.0},{Name:"minecraft:generic.knockback_resistance",Base:1.0}],ArmorItems:[{id:"minecraft:iron_boots",Count:1b},{id:"minecraft:iron_leggings",Count:1b},{id:"minecraft:iron_chestplate",Count:1b},{id:"minecraft:mud_bricks",Count:1b}],HandItems:[{id:"minecraft:bow",Count:1b,tag:{Enchantments:[{id:"minecraft:power",lvl:1},{id:"minecraft:punch",lvl:1}]}},{}]}

# 四条轨道：分别放在四个方位再记相位（0/2/4/6），每 4 刻 +1，绕一圈 32 刻
kill @e[tag=kitpvp.sat_orbit,distance=..6]
summon minecraft:silverfish ~1.5 ~1 ~ {Tags:["kitpvp.earth_minion","kitpvp.sat_orbit"],CustomName:'{"text":"轨道","color":"gray"}',CustomNameVisible:1b,Silent:1b,NoAI:1b,NoGravity:1b,PersistenceRequired:1b,Health:1.0f,Attributes:[{Name:"minecraft:generic.max_health",Base:1.0}]}
scoreboard players set @e[tag=kitpvp.sat_orbit,limit=1,sort=nearest] kitpvp.sat_phase 0
summon minecraft:silverfish ~ ~1 ~1.5 {Tags:["kitpvp.earth_minion","kitpvp.sat_orbit"],CustomName:'{"text":"轨道","color":"gray"}',CustomNameVisible:1b,Silent:1b,NoAI:1b,NoGravity:1b,PersistenceRequired:1b,Health:1.0f,Attributes:[{Name:"minecraft:generic.max_health",Base:1.0}]}
scoreboard players set @e[tag=kitpvp.sat_orbit,limit=1,sort=nearest] kitpvp.sat_phase 2
summon minecraft:silverfish ~-1.5 ~1 ~ {Tags:["kitpvp.earth_minion","kitpvp.sat_orbit"],CustomName:'{"text":"轨道","color":"gray"}',CustomNameVisible:1b,Silent:1b,NoAI:1b,NoGravity:1b,PersistenceRequired:1b,Health:1.0f,Attributes:[{Name:"minecraft:generic.max_health",Base:1.0}]}
scoreboard players set @e[tag=kitpvp.sat_orbit,limit=1,sort=nearest] kitpvp.sat_phase 4
summon minecraft:silverfish ~ ~1 ~-1.5 {Tags:["kitpvp.earth_minion","kitpvp.sat_orbit"],CustomName:'{"text":"轨道","color":"gray"}',CustomNameVisible:1b,Silent:1b,NoAI:1b,NoGravity:1b,PersistenceRequired:1b,Health:1.0f,Attributes:[{Name:"minecraft:generic.max_health",Base:1.0}]}
scoreboard players set @e[tag=kitpvp.sat_orbit,limit=1,sort=nearest] kitpvp.sat_phase 6
