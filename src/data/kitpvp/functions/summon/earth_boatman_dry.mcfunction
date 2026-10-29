# 地球·22 船夫：头戴干海绵、手持木铲的僵尸，坐在樱花木船上
# 上下位别反：船是坐骑（外层），僵尸是乘客（Passengers）
# 船被打掉（2 格内找不到自己的船）→ 给一次 15 秒力量 II，逻辑在 tick
summon minecraft:boat ~ ~ ~ {Tags:["kitpvp.earth_mount","kitpvp.earth_boat2"],Type:"cherry",Passengers:[{id:"minecraft:zombie",Tags:["kitpvp.earth_minion","kitpvp.earth_minion_new","kitpvp.earth_boatman2"],CustomName:'{"text":"船夫","color":"gold"}',CustomNameVisible:1b,PersistenceRequired:1b,CanPickUpLoot:0b,Health:20.0f,HandItems:[{id:"minecraft:wooden_shovel",Count:1b},{}],ArmorItems:[{},{},{},{id:"minecraft:sponge",Count:1b}]}]}
