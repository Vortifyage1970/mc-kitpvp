# 地球·75 蜂巢：头戴蜂巢的僵尸。被打一次就朝 8 格内的玩家扔"眩晕"，挨的次数越多一次扔得越多
# 判定走 advancement（player_hurt_entity 匹配这一只）：谁打的就塞给谁，每下固定 3 张
summon minecraft:zombie ~ ~ ~ {Tags:["kitpvp.earth_minion","kitpvp.earth_minion_new","kitpvp.earth_hive"],CustomName:'{"text":"蜂巢","color":"gold"}',CustomNameVisible:1b,PersistenceRequired:1b,CanPickUpLoot:0b,Health:15.0f,Attributes:[{Name:"minecraft:generic.max_health",Base:15.0}],ArmorItems:[{},{},{},{id:"minecraft:bee_nest",Count:1b}],HandItems:[{},{}]}
scoreboard players set @e[tag=kitpvp.earth_hive] kitpvp.hive_hits 0
