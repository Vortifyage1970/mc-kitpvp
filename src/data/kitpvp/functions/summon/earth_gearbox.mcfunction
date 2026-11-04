# 地球·28 变速器：6 格内没有除召唤者以外的玩家时极速冲刺（速度 X），有人靠近就变慢变肉（抗性 II + 缓慢 V）
# 效果在 tick 里跑（见 skill/earth/gearbox_aura）；砂轮当头饰顺便防火（僵尸戴头盔就不烧）
summon minecraft:zombie ~ ~ ~ {Tags:["kitpvp.earth_minion","kitpvp.earth_minion_new","kitpvp.earth_gearbox"],CustomName:'{"text":"变速器","color":"aqua"}',CustomNameVisible:1b,PersistenceRequired:1b,CanPickUpLoot:0b,Health:20.0f,HandItems:[{id:"minecraft:stone_sword",Count:1b},{}],ArmorItems:[{},{},{},{id:"minecraft:grindstone",Count:1b}],Attributes:[{Name:"minecraft:generic.movement_speed",Base:0.23}]}
scoreboard players set @e[tag=kitpvp.earth_minion_new] kitpvp.earth_cd_a 10
