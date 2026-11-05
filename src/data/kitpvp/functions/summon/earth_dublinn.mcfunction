# 深池飞行兵（试验品，还没进随机池）—— 由原来的"深池飞行兵"改名改配色而来
# 上下位：蠹虫是外层（NoGravity + Invulnerable 的载具），僵尸在 Passengers 里当乘客；移动由 skill/earth/nograv_chase 每刻 tp 拖着走
# 僵尸死了蠹虫也死：tick 里每刻检查 distance=..3 内还有没有 earth_dublinn_zombie，没有就 kill 载具（kill 无视 Invulnerable）
# 配色：胸甲纯黑(0) / 护腿深红(0x8B0000) / 靴子灰(0x808080)；头盔槽是烟熏炉（不是护甲，所以没有保护），那件"淡灰色皮革甲"仍然没地方戴
# 全套保护 I + 耐久 I：三件皮革都挂上；烟熏炉不算护甲，挂了也不生效，所以没挂
# 冷却分 earth_cd_a 先埋好：tick 里 scores={kitpvp.earth_cd_a=..0} 的选择器要求分数已存在，否则整条静默失效
# 双手各一根避雷针（锋利 V）：避雷针近战基础 1 点，锋利 V 再加 6.25 点，够疼
summon minecraft:silverfish ~ ~ ~ {Tags:["kitpvp.earth_dublinn"],CustomName:'{"text":"深池飞行兵","color":"gray"}',CustomNameVisible:1b,PersistenceRequired:1b,CanPickUpLoot:0b,NoGravity:1b,Invulnerable:1b,Passengers:[{id:"minecraft:zombie",Tags:["kitpvp.earth_dublinn_zombie"],CustomName:'{"text":"深池飞行兵","color":"dark_purple"}',CustomNameVisible:1b,PersistenceRequired:1b,CanPickUpLoot:0b,HandItems:[{id:"minecraft:lightning_rod",Count:1b,tag:{Enchantments:[{id:"minecraft:sharpness",lvl:5}]}},{id:"minecraft:lightning_rod",Count:1b,tag:{Enchantments:[{id:"minecraft:sharpness",lvl:5}]}}],ArmorItems:[{id:"minecraft:leather_boots",Count:1b,tag:{display:{color:8421504},Enchantments:[{id:"minecraft:protection",lvl:1},{id:"minecraft:unbreaking",lvl:1}]}},{id:"minecraft:leather_leggings",Count:1b,tag:{display:{color:9109504},Enchantments:[{id:"minecraft:protection",lvl:1},{id:"minecraft:unbreaking",lvl:1}]}},{id:"minecraft:leather_chestplate",Count:1b,tag:{display:{color:0},Enchantments:[{id:"minecraft:protection",lvl:1},{id:"minecraft:unbreaking",lvl:1}]}},{id:"minecraft:smoker",Count:1b}]}]}
effect give @e[tag=kitpvp.earth_dublinn_zombie] minecraft:resistance infinite 1 true
scoreboard players set @e[tag=kitpvp.earth_dublinn] kitpvp.earth_cd_a 1
