# 地球·74 罐子：头戴陶罐的僵尸。被打死时在原地摇出一只随机生灵（主人编号原样传给新生的那只）
# 摇号在 skill/earth/jar_pop 里做：罐子尸体还留在世界上的那几刻（Health:0.0f）触发，先打 tag 防重复
# 不来这里放 rng / 冷却：罐子没有主动技能，只在死亡时干活
summon minecraft:zombie ~ ~ ~ {Tags:["kitpvp.earth_minion","kitpvp.earth_minion_new","kitpvp.earth_jar"],CustomName:'{"text":"罐子","color":"gold"}',CustomNameVisible:1b,PersistenceRequired:1b,CanPickUpLoot:0b,ArmorItems:[{},{},{},{id:"minecraft:decorated_pot",Count:1b}],HandItems:[{},{}]}
