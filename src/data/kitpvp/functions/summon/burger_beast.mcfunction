# 汉堡兽（参照 1.12.2 原版）：50 血僵尸、完全免疫击退、超高攻击与移速、超大追踪范围
# 头/双手橙色混凝土粉末（原版肉饼外观），金靴/金护腿/金胸甲；抗性 V + 跳跃提升 VI 常驻
# 对**所有**玩家敌对（不加入任何队）
summon minecraft:zombie ~ ~ ~ {Tags:["kitpvp.burger_beast"],CustomName:'{"text":"汉堡兽"}',CustomNameVisible:1b,PersistenceRequired:1b,CanPickUpLoot:0b,Health:50f,Attributes:[{Name:"minecraft:generic.max_health",Base:50.0},{Name:"minecraft:generic.knockback_resistance",Base:1.0},{Name:"minecraft:generic.attack_damage",Base:150.0},{Name:"minecraft:generic.movement_speed",Base:1.9},{Name:"minecraft:generic.follow_range",Base:85.0}],HandItems:[{id:"minecraft:orange_concrete_powder",Count:1b},{}],HandDropChances:[0.0f,0.0f],ArmorItems:[{id:"minecraft:golden_boots",Count:1b},{id:"minecraft:golden_leggings",Count:1b},{id:"minecraft:golden_chestplate",Count:1b},{id:"minecraft:orange_concrete_powder",Count:1b}],ArmorDropChances:[0.0f,0.0f,0.0f,0.0f]}
# 原版每 2 秒刷新：抗性提升 V（amplifier 4）+ 跳跃提升 VI（amplifier 5）。这里用常驻等价
effect give @e[tag=kitpvp.burger_beast] minecraft:resistance infinite 4 true
effect give @e[tag=kitpvp.burger_beast] minecraft:jump_boost infinite 5 true
