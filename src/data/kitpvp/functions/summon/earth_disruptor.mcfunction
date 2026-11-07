# 地球·17 扰动者：头戴侦测器、手持红火把；每 3 秒对 11 格内玩家发动太阳耀斑的中招效果
summon minecraft:zombie ~ ~ ~ {Tags:["kitpvp.earth_minion","kitpvp.earth_minion_new","kitpvp.earth_disruptor"],CustomName:'{"text":"扰动者","color":"dark_red"}',CustomNameVisible:1b,PersistenceRequired:1b,CanPickUpLoot:0b,Health:12.0f,Attributes:[{Name:"minecraft:generic.max_health",Base:12.0}],HandItems:[{id:"minecraft:redstone_torch",Count:1b},{}],ArmorItems:[{},{},{},{id:"minecraft:observer",Count:1b}]}
scoreboard players set @e[tag=kitpvp.earth_minion_new] kitpvp.earth_cd_a 60
