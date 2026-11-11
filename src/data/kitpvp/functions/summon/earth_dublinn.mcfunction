# 地球·55 深池飞行兵 —— 由原来的"深池飞行兵"改名改配色而来；已在随机池里（54 号）
# 上下位：蠹虫是外层（NoGravity + Invulnerable 的载具），僵尸在 Passengers 里当乘客；移动由 skill/earth/nograv_chase 每刻 tp 拖着走
# 僵尸死了蠹虫也死：tick 里每刻检查 distance=..3 内还有没有 earth_dublinn_zombie，没有就 kill 载具（kill 无视 Invulnerable）
# 配色：胸甲纯黑(0) / 护腿深红(0x8B0000) / 靴子灰(0x808080)；头盔槽是烟熏炉（不是护甲，所以没有保护），那件"淡灰色皮革甲"仍然没地方戴
# 全套保护 I + 耐久 I：三件皮革都挂上；烟熏炉不算护甲，挂了也不生效，所以没挂
# ★ 蠹虫身上必须有 earth_minion / earth_minion_new / earth_mount 三个标签：link 靠 _new 赋 earth_owner 并组队，reset 靠 earth_minion 与 earth_mount 清场
# ★ 乘客僵尸也必须带 earth_minion_new：不带就只有载具进了队，僵尸留在队外 ⇒ 原版 AI 会去追召唤者（"代码索敌是别人，僵尸却奔着我"就是这个）
# 僵尸血量 15 滴（7.5 颗心），另叠加抗性提升 II（每级 -20%，实际很硬）
# ★ 乘客僵尸加 NoAI：它是乘客、本来就走不了路，留着原版 AI 只会自己锁一个目标跟代码打架（"改不了索敌目标"就是它）
#   伤害与追击都由 skill/earth/dublinn_strike + nograv_step 负责，僵尸本身的 AI 没有任何用处
# 冷却分 earth_cd_a 先埋好：tick 里 scores={kitpvp.earth_cd_a=..0} 的选择器要求分数已存在，否则整条静默失效
# 双手各一根避雷针（锋利 V）：避雷针近战基础 1 点，锋利 V 再加 6.25 点，够疼
summon minecraft:silverfish ~ ~ ~ {Tags:["kitpvp.earth_minion","kitpvp.earth_minion_new","kitpvp.earth_mount","kitpvp.earth_dublinn"],CustomName:'{"text":"深池飞行兵","color":"gray"}',CustomNameVisible:1b,PersistenceRequired:1b,CanPickUpLoot:0b,NoGravity:1b,Invulnerable:1b,Passengers:[{id:"minecraft:zombie",Tags:["kitpvp.earth_minion","kitpvp.earth_minion_new","kitpvp.earth_dublinn_zombie"],CustomName:'{"text":"深池飞行兵","color":"dark_purple"}',CustomNameVisible:1b,PersistenceRequired:1b,CanPickUpLoot:0b,NoAI:1b,Health:9.0f,Attributes:[{Name:"minecraft:generic.max_health",Base:9.0}],HandItems:[{id:"minecraft:lightning_rod",Count:1b,tag:{Enchantments:[{id:"minecraft:sharpness",lvl:5}]}},{id:"minecraft:lightning_rod",Count:1b,tag:{Enchantments:[{id:"minecraft:sharpness",lvl:5}]}}],ArmorItems:[{id:"minecraft:leather_boots",Count:1b,tag:{display:{color:8421504},Enchantments:[{id:"minecraft:protection",lvl:1},{id:"minecraft:unbreaking",lvl:1}]}},{id:"minecraft:leather_leggings",Count:1b,tag:{display:{color:9109504},Enchantments:[{id:"minecraft:protection",lvl:1},{id:"minecraft:unbreaking",lvl:1}]}},{id:"minecraft:leather_chestplate",Count:1b,tag:{display:{color:0},Enchantments:[{id:"minecraft:protection",lvl:1},{id:"minecraft:unbreaking",lvl:1}]}},{id:"minecraft:smoker",Count:1b}]}]}
effect give @e[tag=kitpvp.earth_dublinn_zombie] minecraft:resistance infinite 1 true
scoreboard players set @e[tag=kitpvp.earth_dublinn] kitpvp.earth_cd_a 1
#
# ★ 不用 link：手动 /function 是给测试用的 —— 没有主人 ⇒ 它谁近打谁（包括你自己）
#   走随机池 / 魂石召唤时才由 link 写 earth_owner，那才是"不打召唤者"的正规路径
scoreboard players set @a kitpvp.dl_summoner 0
scoreboard players set @s kitpvp.dl_summoner 1
