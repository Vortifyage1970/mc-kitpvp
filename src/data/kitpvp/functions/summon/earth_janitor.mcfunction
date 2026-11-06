# 地球·66 保洁员：头顶湿海绵、手拿刷子的僵尸，每 15 秒把 8 格内所有掉落物吸走（连你的战利品一起）
# 负收益设计：它不抢你手上的东西，只清地上 —— 打完架想捡装备就得赶在它下一轮之前
summon minecraft:zombie ~ ~ ~ {Tags:["kitpvp.earth_minion","kitpvp.earth_minion_new","kitpvp.earth_janitor"],CustomName:'{"text":"保洁员","color":"white"}',CustomNameVisible:1b,PersistenceRequired:1b,CanPickUpLoot:0b,Health:20.0f,Attributes:[{Name:"minecraft:generic.max_health",Base:20.0}],HandItems:[{id:"minecraft:brush",Count:1b},{}],ArmorItems:[{},{},{},{id:"minecraft:wet_sponge",Count:1b}]}
scoreboard players set @e[tag=kitpvp.earth_janitor] kitpvp.earth_cd_a 300
