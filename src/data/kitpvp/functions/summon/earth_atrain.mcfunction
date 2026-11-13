# 地球·72 火车头（atrain）：速度 IV 的僵尸，头戴闪长岩楼梯，击退抗性 100%（打不退）
# 闪长岩楼梯塞头顶：方块占住头盔位 ⇒ 白天不自燃，看起来就是一节顶着石阶的车头
# 击退抗性 1.0 = 原版上限（100%），只有爆炸/活塞之类的位移才会推动它
# 速度用 effect give 挂无限时长：写在 ActiveEffects 里偶尔会被药水覆盖，effect 更稳
summon minecraft:zombie ~ ~ ~ {Tags:["kitpvp.earth_minion","kitpvp.earth_minion_new","kitpvp.earth_atrain"],CustomName:'{"text":"火车头","color":"gold"}',CustomNameVisible:1b,PersistenceRequired:1b,CanPickUpLoot:0b,Health:20.0f,Attributes:[{Name:"minecraft:generic.max_health",Base:20.0},{Name:"minecraft:generic.knockback_resistance",Base:1.0}],HandItems:[{},{}],ArmorItems:[{},{},{},{id:"minecraft:diorite_stairs",Count:1b}]}
effect give @e[tag=kitpvp.earth_atrain] minecraft:speed infinite 3 true
