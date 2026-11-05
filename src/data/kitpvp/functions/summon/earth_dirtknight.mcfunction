# 泥土骑士（试验品，还没进随机池）：无重力 + 打不死的蠹虫，背上一只头顶泥土块（普通泥土）的僵尸
# 打不死的实现是 Invulnerable:1b（免疫一切伤害，但 /kill 与 reset 的按 tag 清场照样有效）
# 唯一的下场：僵尸死 → tick 里那条「背上找不到僵尸」把蠹虫也 kill 掉（见 tick.mcfunction 地球段）
# 反过来说，玩家想弄死这只蠹虫，只能先打死它背上那只僵尸
summon minecraft:silverfish ~ ~ ~ {Tags:["kitpvp.earth_minion","kitpvp.earth_minion_new","kitpvp.earth_dirtknight"],CustomName:'{"text":"泥土骑士","color":"gray"}',CustomNameVisible:1b,PersistenceRequired:1b,CanPickUpLoot:0b,Silent:1b,NoGravity:1b,Invulnerable:1b,Passengers:[{id:"minecraft:zombie",Tags:["kitpvp.earth_dirt_zombie"],CustomName:'{"text":"泥土头僵尸","color":"gold"}',CustomNameVisible:1b,PersistenceRequired:1b,CanPickUpLoot:0b,Silent:1b,ArmorItems:[{},{},{},{id:"minecraft:dirt",Count:1b}]}]}
