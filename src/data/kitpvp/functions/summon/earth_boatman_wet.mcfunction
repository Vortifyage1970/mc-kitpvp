# 地球·21 船夫：头戴湿海绵、手持木铲的僵尸，坐在竹筏上
# 上下位别反：船是坐骑（外层），僵尸是乘客（Passengers）
# 坐在筏上时有抗性提升 V；下筏或筏被打破就撤掉（tick 里按"2 格内还有没有自己的筏"判定）
summon minecraft:boat ~ ~ ~ {Tags:["kitpvp.earth_mount","kitpvp.earth_boat1"],Type:"bamboo",Passengers:[{id:"minecraft:zombie",Tags:["kitpvp.earth_minion","kitpvp.earth_minion_new","kitpvp.earth_boatman1"],CustomName:'{"text":"船夫","color":"blue"}',CustomNameVisible:1b,PersistenceRequired:1b,CanPickUpLoot:0b,Health:20.0f,HandItems:[{id:"minecraft:wooden_shovel",Count:1b},{}],ArmorItems:[{},{},{},{id:"minecraft:wet_sponge",Count:1b}],ActiveEffects:[{Id:11b,Amplifier:4b,Duration:-1,ShowParticles:0b}]}]}
