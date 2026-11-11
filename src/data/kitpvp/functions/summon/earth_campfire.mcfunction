# 地球·62 篝火：菌光体当头的骷髅，常驻抗性提升 II；挨打就会被点着，烧 5 秒（100 刻）后自己熄灭
# 熄灭之后 fire_left = -1（"待点火"），下一次挨打会把它重新设成 100 ⇒ 又可以再次燃烧
# 别把 fire_left 设成 0 当"待机值"：0 是"这一帧刚烧完"的哨兵，campfire_out 靠它只触发一次
summon minecraft:skeleton ~ ~ ~ {Tags:["kitpvp.earth_minion","kitpvp.earth_minion_new","kitpvp.earth_campfire"],CustomName:'{"text":"篝火","color":"gold"}',CustomNameVisible:1b,PersistenceRequired:1b,CanPickUpLoot:0b,Health:20.0f,Attributes:[{Name:"minecraft:generic.max_health",Base:20.0}],HandItems:[{},{}],ArmorItems:[{},{},{},{id:"minecraft:shroomlight",Count:1b}]}
effect give @e[tag=kitpvp.earth_campfire] minecraft:resistance infinite 1 true
scoreboard players set @e[tag=kitpvp.earth_campfire] kitpvp.fire_left -1
scoreboard players set @e[tag=kitpvp.earth_campfire] kitpvp.fire_prev 2000
execute as @e[tag=kitpvp.earth_campfire] store result score @s kitpvp.fire_hp run data get entity @s Health 100
