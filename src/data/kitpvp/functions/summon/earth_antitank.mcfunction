# 地球·78 反装甲步兵：头戴砂轮的骷髅，15 血
# 装填时缓慢 III、打完之后换速度 I 抢位置；手里拿锋利 III 的深板岩砖墙（当钝器用）
# 炮是"快速迫击炮"：炮弹每刻 1.2 格直线飞向落点，命中半径 2.5 内吃 6 点魔法伤害（无视护甲 = 反装甲）
summon minecraft:skeleton ~ ~ ~ {Tags:["kitpvp.earth_minion","kitpvp.earth_minion_new","kitpvp.earth_antitank"],CustomName:'{"text":"反装甲步兵","color":"dark_purple"}',CustomNameVisible:1b,PersistenceRequired:1b,CanPickUpLoot:0b,Health:15.0f,Attributes:[{Name:"minecraft:generic.max_health",Base:15.0}],HandItems:[{id:"minecraft:deepslate_brick_wall",Count:1b,tag:{Enchantments:[{id:"minecraft:sharpness",lvl:3s}]}},{}],ArmorItems:[{id:"minecraft:leather_boots",Count:1b,tag:{display:{color:16777215}}},{id:"minecraft:leather_leggings",Count:1b,tag:{display:{color:8355711}}},{id:"minecraft:leather_chestplate",Count:1b,tag:{display:{color:8355711}}},{id:"minecraft:polished_basalt",Count:1b}]}
# 装填期常驻缓慢 III（amplifier 2 = III 级，-45% 移速）；分数初值必须埋，否则 ..0 的闸门不匹配
effect give @e[tag=kitpvp.earth_antitank] minecraft:slowness infinite 2 true
scoreboard players set @e[tag=kitpvp.earth_antitank] kitpvp.at_charge 0
