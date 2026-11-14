# 地球·75 铁人：NoAI 僵尸（不会自己走、不会自己打），靠 ironman_tick 每刻 tp 驱着走
# 造型：全套铁装 + 铁块头（钢铁侠的红金配色靠皮革染不出来，铁装反而最像"铁甲人"）
summon minecraft:zombie ~ ~ ~ {Tags:["kitpvp.earth_minion","kitpvp.earth_minion_new","kitpvp.earth_ironman"],CustomName:'{"text":"铁人","color":"aqua"}',CustomNameVisible:1b,PersistenceRequired:1b,CanPickUpLoot:0b,NoAI:1b,Health:20.0f,Attributes:[{Name:"minecraft:generic.max_health",Base:20.0},{Name:"minecraft:generic.attack_damage",Base:3.0}],HandItems:[{},{}],ArmorItems:[{id:"minecraft:iron_boots",Count:1b},{id:"minecraft:iron_leggings",Count:1b},{id:"minecraft:iron_chestplate",Count:1b},{id:"minecraft:iron_block",Count:1b}]}
scoreboard players set @e[tag=kitpvp.earth_ironman] kitpvp.im_cd 100
