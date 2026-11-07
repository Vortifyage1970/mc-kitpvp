# 地球·70 迫击炮：蹲在铁甲里的一门炮，20 格内有人就每 3 秒扔一条会炸的鱼（抛物线）
# 爆炸只伤人、不炸地形 —— 能拆图的炸弹放进 kitpvp 就没法玩了
# 单人测试时它会朝你自己打：爆炸那一步会跳过主人，所以只看得见、不会掉血
summon minecraft:zombie ~ ~ ~ {Tags:["kitpvp.earth_minion","kitpvp.earth_minion_new","kitpvp.earth_mortar"],CustomName:'{"text":"迫击炮","color":"dark_red"}',CustomNameVisible:1b,Silent:1b,PersistenceRequired:1b,NoAI:1b,CanPickUpLoot:0b,Health:24.0f,Attributes:[{Name:"minecraft:generic.max_health",Base:24.0},{Name:"minecraft:generic.movement_speed",Base:0}],ArmorItems:[{id:"minecraft:iron_boots",Count:1b},{id:"minecraft:iron_leggings",Count:1b},{id:"minecraft:iron_chestplate",Count:1b},{id:"minecraft:dispenser",Count:1b}],HandItems:[{},{}]}
scoreboard players set @e[tag=kitpvp.earth_mortar] kitpvp.earth_cd_a 40
