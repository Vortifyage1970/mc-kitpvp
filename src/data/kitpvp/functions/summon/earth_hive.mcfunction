# 地球·75 蜂巢：头戴蜂巢的僵尸。被打一次就朝 8 格内的玩家扔"眩晕"，挨的次数越多一次扔得越多
# 计数在 kitpvp.hive_hits 上：第 1 下 1 个、第 2 下 2 个、第 3 下及以后每次 3 个
summon minecraft:zombie ~ ~ ~ {Tags:["kitpvp.earth_minion","kitpvp.earth_minion_new","kitpvp.earth_hive"],CustomName:'{"text":"蜂巢","color":"gold"}',CustomNameVisible:1b,PersistenceRequired:1b,CanPickUpLoot:0b,ArmorItems:[{},{},{},{id:"minecraft:bee_nest",Count:1b}],HandItems:[{},{}]}
scoreboard players set @e[tag=kitpvp.earth_hive] kitpvp.hive_hits 0
