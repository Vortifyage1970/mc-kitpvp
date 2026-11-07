# 地球·74 罐子：头戴陶罐的僵尸。被打死时在原地摇出一只随机生灵（主人编号原样传给新生的那只）
# 摇号在 skill/earth/jar_pop 里做：脚下埋一个隐形 marker 当"守卫"，罐子没了就在守卫脚下摇（尸体帧抓不到，木星踩过的坑）
# 不来这里放 rng / 冷却：罐子没有主动技能，只在死亡时干活
summon minecraft:zombie ~ ~ ~ {Tags:["kitpvp.earth_minion","kitpvp.earth_minion_new","kitpvp.earth_jar"],CustomName:'{"text":"罐子","color":"gold"}',CustomNameVisible:1b,PersistenceRequired:1b,CanPickUpLoot:0b,ArmorItems:[{},{},{},{id:"minecraft:decorated_pot",Count:1b}],HandItems:[{},{}]}
summon minecraft:marker ~ ~ ~ {Tags:["kitpvp.earth_jar_guard"]}
