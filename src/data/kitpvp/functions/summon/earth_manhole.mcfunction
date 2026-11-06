# 地球·61 井盖：召唤时直接埋进脚下 2 格的土里，视野里完全看不到
# 无敌（Invulnerable）是必要的：埋在方块里会持续吃窒息伤害，无敌能挡掉这一类（但挡不住 /kill 与虚空）
# NoAI + Silent：不能动、不出声，否则地底会有脚步声和骨头摩擦声
# earth_cd_a 40 = 埋好之后有 2 秒"装填期"，这期间踩上去不会触发（也不会被召唤者自己当场顶出来）
summon minecraft:skeleton ~ ~-2 ~ {Tags:["kitpvp.earth_minion","kitpvp.earth_minion_new","kitpvp.earth_manhole"],CustomName:'{"text":"井盖","color":"gray"}',CustomNameVisible:1b,PersistenceRequired:1b,CanPickUpLoot:0b,Silent:1b,NoAI:1b,Invulnerable:1b,Health:20.0f,Attributes:[{Name:"minecraft:generic.max_health",Base:20.0}],HandItems:[{},{}],ArmorItems:[{},{},{},{id:"minecraft:suspicious_gravel",Count:1b}]}
scoreboard players set @e[tag=kitpvp.earth_manhole] kitpvp.earth_cd_a 40
