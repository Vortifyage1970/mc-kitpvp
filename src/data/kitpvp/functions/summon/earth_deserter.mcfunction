# 地球·81 逃兵：会正常打人，但一挨到半血（10 点以下）就掉头跑，跑出 16 格算"跑掉了"
# 用尸壳：白天不烧；铁剑 + 全套灰色皮革，20 血
# 血量每刻用 data get 读进 dser_hp（直接拿 NBT 比 Health 浮点不可靠，别那么干）
kill @e[tag=kitpvp.earth_deserter]
summon minecraft:husk ~ ~ ~ {Tags:["kitpvp.earth_minion","kitpvp.earth_minion_new","kitpvp.earth_deserter"],CustomName:'{"text":"逃兵","color":"yellow"}',CustomNameVisible:1b,Silent:1b,PersistenceRequired:1b,CanPickUpLoot:0b,Health:20.0f,Attributes:[{Name:"minecraft:generic.max_health",Base:20.0}],HandItems:[{id:"minecraft:iron_sword",Count:1b},{}],ArmorItems:[{id:"minecraft:leather_boots",Count:1b,tag:{display:{color:6710886}}},{id:"minecraft:leather_leggings",Count:1b,tag:{display:{color:6710886}}},{id:"minecraft:leather_chestplate",Count:1b,tag:{display:{color:6710886}}},{id:"minecraft:leather_helmet",Count:1b,tag:{display:{color:6710886}}}]}
scoreboard players set @e[tag=kitpvp.earth_deserter,limit=1,sort=nearest] kitpvp.dser_hp 20
