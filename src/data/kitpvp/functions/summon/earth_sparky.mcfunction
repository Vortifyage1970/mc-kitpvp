# 地球·54 电磁炮（Sparky）：NoAI 的劫掠兽当炮台，5 秒充能、放电一次 14 点魔法伤害（magic 无视护甲）
# NoAI：不挥爪、不自己追；位移交给 skill/earth/sparky_move 每刻 tp 0.05 格（≈1 格/秒，慢到能走位躲）
# 充能用独立 objective kitpvp.sparky_charge，不占 earth_cd_a（那个被 tick 全局递减，共用会互相打架）
# 劫掠兽不渲染护甲，所以没有 ArmorItems；外观靠名字金色 + 充能时的电弧粒子
summon minecraft:ravager ~ ~ ~ {Tags:["kitpvp.earth_minion","kitpvp.earth_minion_new","kitpvp.earth_sparky"],CustomName:'{"text":"电磁炮","color":"gold"}',CustomNameVisible:1b,PersistenceRequired:1b,NoAI:1b,CanPickUpLoot:0b,Health:100.0f,Attributes:[{Name:"minecraft:generic.max_health",Base:100.0},{Name:"minecraft:generic.movement_speed",Base:0.1}]}
scoreboard players set @e[tag=kitpvp.earth_sparky] kitpvp.sparky_charge 0
