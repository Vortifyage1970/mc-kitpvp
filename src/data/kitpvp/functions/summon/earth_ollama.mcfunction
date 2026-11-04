# 地球·31 Ollama：白色羊驼，每掉一次血就在聊天框打一行 ollama run（判定在 tick.mcfunction:283-285）
# Variant：0 奶油色 / 1 白色 / 2 棕色 / 3 灰色 —— 羊驼的毛色存在和马的 Variant 同一个字段里
summon minecraft:llama ~ ~ ~ {Tags:["kitpvp.earth_minion","kitpvp.earth_minion_new","kitpvp.earth_ollama"],CustomName:'{"text":"Ollama","color":"white"}',CustomNameVisible:1b,PersistenceRequired:1b,CanPickUpLoot:0b,Variant:1,Health:20.0f,Attributes:[{Name:"minecraft:generic.max_health",Base:20.0}]}
# 出生先记一次血（Health x10 存成分数），免得刚召出来那刻被当成"掉了血"
execute as @e[tag=kitpvp.earth_minion_new] store result score @s kitpvp.earth_hp run data get entity @s Health 10
