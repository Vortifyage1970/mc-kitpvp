# 可疑草丛被惊动（@s = 草丛本身）：原地留下两个 8 血、移速略低于普通僵尸（0.18）的小僵尸，自己消失
# 首行先打 popped：kill 的移除在下一刻，不打这个标记的话同一刻的"贴近"与"掉血"两条判定会各调一次，变四只
tag @s add kitpvp.earth_grass_popped
# 小僵尸要沿用草丛的队伍，否则刚出来就打召唤者（队伍只能在草丛身上读到，所以用 6 行按队复制）
summon minecraft:zombie ~ ~ ~ {IsBaby:1b,Tags:["kitpvp.earth_minion","kitpvp.earth_grass_new"],CustomName:'{"text":"小僵尸","color":"dark_green"}',CustomNameVisible:1b,PersistenceRequired:1b,CanPickUpLoot:0b,Health:8.0f,HandItems:[{},{}],ArmorItems:[{},{},{},{id:"minecraft:oak_leaves",Count:1b}],Attributes:[{Name:"minecraft:generic.max_health",Base:8.0},{Name:"minecraft:generic.movement_speed",Base:0.18}]}
summon minecraft:zombie ~ ~ ~ {IsBaby:1b,Tags:["kitpvp.earth_minion","kitpvp.earth_grass_new"],CustomName:'{"text":"小僵尸","color":"dark_green"}',CustomNameVisible:1b,PersistenceRequired:1b,CanPickUpLoot:0b,Health:8.0f,HandItems:[{},{}],ArmorItems:[{},{},{},{id:"minecraft:oak_leaves",Count:1b}],Attributes:[{Name:"minecraft:generic.max_health",Base:8.0},{Name:"minecraft:generic.movement_speed",Base:0.18}]}

execute if entity @s[team=earth_1] run team join earth_1 @e[tag=kitpvp.earth_grass_new]
execute if entity @s[team=earth_2] run team join earth_2 @e[tag=kitpvp.earth_grass_new]
execute if entity @s[team=earth_3] run team join earth_3 @e[tag=kitpvp.earth_grass_new]
execute if entity @s[team=earth_4] run team join earth_4 @e[tag=kitpvp.earth_grass_new]
execute if entity @s[team=earth_5] run team join earth_5 @e[tag=kitpvp.earth_grass_new]
execute if entity @s[team=earth_6] run team join earth_6 @e[tag=kitpvp.earth_grass_new]
tag @e[tag=kitpvp.earth_grass_new] remove kitpvp.earth_grass_new

particle minecraft:composter ~ ~1 ~ 0.4 0.4 0.4 0.05 12
playsound minecraft:block.grass.break master @s ~ ~ ~ 0.8 0.8
kill @s
