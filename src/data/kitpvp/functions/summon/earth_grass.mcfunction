# 地球·25 可疑草丛：树叶片头 + 隐身、移速 -30%、20 血的僵尸
# 不显示名字：它就是"草丛"，靠隐身混在人堆里
# 落地 2 秒（earth_grass_arm 40 刻）后才会被玩家贴近触发，免得刚召出来就在自己脚下爆开
summon minecraft:zombie ~ ~ ~ {Tags:["kitpvp.earth_minion","kitpvp.earth_minion_new","kitpvp.earth_grass"],CustomName:'{"text":"可疑草丛","color":"dark_green"}',CustomNameVisible:0b,PersistenceRequired:1b,CanPickUpLoot:0b,Health:20.0f,HandItems:[{},{}],ArmorItems:[{},{},{},{id:"minecraft:oak_leaves",Count:1b}],ActiveEffects:[{Id:14b,Amplifier:0b,Duration:-1,ShowParticles:0b}],Attributes:[{Name:"minecraft:generic.movement_speed",Base:0.161}]}
scoreboard players set @e[tag=kitpvp.earth_minion_new] kitpvp.earth_grass_arm 40
