# 地球·29 交警：头戴磁石、坐矿车出场的僵尸；矿车 10 秒后消失，他下车继续走
# 上下位别反：矿车是坐骑（外层），僵尸是乘客（Passengers）——与船夫 / 随从同一套写法
# 常驻速度 II + 力量 I 用 infinite；矿车 Invulnerable，打不掉，只能等倒计时
summon minecraft:minecart ~ ~ ~ {Tags:["kitpvp.earth_mount","kitpvp.earth_cop_cart"],Invulnerable:1b,Passengers:[{id:"minecraft:zombie",Tags:["kitpvp.earth_minion","kitpvp.earth_minion_new","kitpvp.earth_cop"],CustomName:'{"text":"交警","color":"yellow"}',CustomNameVisible:1b,PersistenceRequired:1b,CanPickUpLoot:0b,Health:20.0f,HandItems:[{},{}],ArmorItems:[{},{},{},{id:"minecraft:lodestone",Count:1b}]}]}
# 10 秒 = 200 刻，挂矿车自己的 earth_cd_a（tick 第 253 行统一每刻 -1，归零那行 kill 掉矿车，乘客自然落地）
scoreboard players set @e[tag=kitpvp.earth_cop_cart] kitpvp.earth_cd_a 200
# 常驻增益（infinite：读档、重生都不掉）
effect give @e[tag=kitpvp.earth_cop] minecraft:speed infinite 1 true
effect give @e[tag=kitpvp.earth_cop] minecraft:strength infinite 0 true
