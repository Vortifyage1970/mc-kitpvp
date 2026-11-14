# 农夫魂石：20 血的起义领袖（与里农夫同款特性：常驻力量 II / 速度 I、每 12 秒带兵），没有时限
summon minecraft:zombie ~ ~ ~ {Tags:["kitpvp.tf_leader","kitpvp.soul_farm_leader","kitpvp.tf_new","kitpvp.team_new"],CustomName:'{"text":"农民起义领袖","color":"gold"}',CustomNameVisible:1b,PersistenceRequired:1b,CanPickUpLoot:0b,HandItems:[{id:"minecraft:diamond_hoe",Count:1b},{}],ArmorItems:[{},{},{id:"minecraft:diamond_chestplate",Count:1b},{id:"minecraft:player_head",Count:1b}],Health:20f,Attributes:[{Name:"minecraft:generic.max_health",Base:20.0}]}
effect give @e[tag=kitpvp.soul_farm_leader,tag=kitpvp.tf_new] minecraft:strength infinite 1 true
effect give @e[tag=kitpvp.soul_farm_leader,tag=kitpvp.tf_new] minecraft:speed infinite 0 true
