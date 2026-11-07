# 地球·77 小罐子：顶陶罐的小僵尸，跑得快、个子矮，比大罐子更难瞄；10 血（比大罐子的 20 血脆一半）。
# 死亡判定与碎裂召唤跟 74 号完全共用 skill/earth/jar_pop（同样挂 kitpvp.earth_jar 与守卫 marker）。
summon minecraft:zombie ~ ~ ~ {IsBaby:1b,Tags:["kitpvp.earth_minion","kitpvp.earth_minion_new","kitpvp.earth_jar"],CustomName:'{"text":"罐子","color":"gold"}',CustomNameVisible:1b,PersistenceRequired:1b,CanPickUpLoot:0b,Health:10.0f,Attributes:[{Name:"minecraft:generic.max_health",Base:10.0}],ArmorItems:[{},{},{},{id:"minecraft:decorated_pot",Count:1b}],HandItems:[{},{}]}
summon minecraft:marker ~ ~ ~ {Tags:["kitpvp.earth_jar_guard"]}
