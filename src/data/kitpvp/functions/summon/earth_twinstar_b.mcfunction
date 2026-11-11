# 双星 B：一只 8 血的小白（骷髅），头戴绯红菌核。与 A（僵尸）对称，只是名字、颜色、菌核、tag 和本体换成 b
# 骷髅要射箭，头顶有方块也算"戴头盔"，白天不会被晒着
summon minecraft:skeleton ~ ~ ~ {Tags:["kitpvp.earth_minion","kitpvp.earth_minion_new","kitpvp.earth_twinstar_b"],CustomName:'{"text":"双星B","color":"red"}',CustomNameVisible:1b,PersistenceRequired:1b,CanPickUpLoot:0b,Health:8.0f,Attributes:[{Name:"minecraft:generic.max_health",Base:8.0}],ArmorItems:[{},{},{},{id:"minecraft:crimson_hyphae",Count:1b}]}
summon minecraft:marker ~ ~ ~ {Tags:["kitpvp.earth_twinstar_guard_b"]}