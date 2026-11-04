# 地球·36 矿车：一只头顶橡木船、坐在矿车里的蠹虫；常驻速度 I + 虚弱 I
# 上下位别反：矿车是坐骑（外层），蠹虫是乘客（Passengers）——与交警 / 船夫 / 随从同一套写法
# 矿车 Invulnerable，砍不烂；蠹虫本身只有 0.4 格高，坐在车里基本被挡住，只看得见名牌和头上那片船
# 虚弱 I 会把它的近战再削一截（蠹虫本来只打 1 点），速度 I 只对它下车以后有意义
summon minecraft:minecart ~ ~ ~ {Tags:["kitpvp.earth_mount","kitpvp.earth_minecart_cart"],Invulnerable:1b,Passengers:[{id:"minecraft:silverfish",Tags:["kitpvp.earth_minion","kitpvp.earth_minion_new","kitpvp.earth_minecart"],CustomName:'{"text":"矿车","color":"gray"}',CustomNameVisible:1b,PersistenceRequired:1b,CanPickUpLoot:0b,ArmorItems:[{},{},{},{id:"minecraft:oak_boat",Count:1b}],ActiveEffects:[{Id:1b,Amplifier:0b,Duration:-1,ShowParticles:0b},{Id:18b,Amplifier:0b,Duration:-1,ShowParticles:0b}]}]}
