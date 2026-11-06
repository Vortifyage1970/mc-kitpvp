# 地球·64 制图台：制图台当头的僵尸，主手拎着一张画；每次打中玩家就在聊天栏刷一条"制图台提醒您 X"
# X 是八个固定字符串之一（七串 pid + 一句"该作品已删除或不公开"），3 位随机均匀取
summon minecraft:zombie ~ ~ ~ {Tags:["kitpvp.earth_minion","kitpvp.earth_minion_new","kitpvp.earth_carto"],CustomName:'{"text":"制图台","color":"white"}',CustomNameVisible:1b,PersistenceRequired:1b,CanPickUpLoot:0b,Health:20.0f,Attributes:[{Name:"minecraft:generic.max_health",Base:20.0}],HandItems:[{id:"minecraft:painting",Count:1b},{}],ArmorItems:[{},{},{},{id:"minecraft:cartography_table",Count:1b}]}
scoreboard players set @e[tag=kitpvp.earth_carto] kitpvp.earth_cd_a 0
