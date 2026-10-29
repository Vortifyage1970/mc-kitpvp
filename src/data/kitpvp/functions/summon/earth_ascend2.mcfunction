# 地球·20 超凡升天：南瓜头 + 金斧，生命上限 40；3 秒后漂浮 V 15 秒，再 15 秒后清除
summon minecraft:zombie ~ ~ ~ {Tags:["kitpvp.earth_minion","kitpvp.earth_minion_new","kitpvp.earth_levitate"],CustomName:'{"text":"超凡升天","color":"aqua"}',CustomNameVisible:1b,PersistenceRequired:1b,CanPickUpLoot:0b,Health:40.0f,Attributes:[{Name:"minecraft:generic.max_health",Base:40.0}],HandItems:[{id:"minecraft:golden_axe",Count:1b},{}],ArmorItems:[{},{},{},{id:"minecraft:carved_pumpkin",Count:1b}]}
scoreboard players set @e[tag=kitpvp.earth_minion_new] kitpvp.earth_lev 60
