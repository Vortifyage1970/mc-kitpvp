# 地球·80 冥王星：隐形的抗性提升 V 僵尸，肩头坐着一只 30 血的鹦鹉
# 鹦鹉一死，僵尸跟着死；僵尸没了，鹦鹉也不留（见 skill/earth/pluto_tick）
# 鹦鹉刻意不带 kitpvp.pluto_parrot —— 那个 tag 是「冥王星职业」分身的，串上会被它的 follow/check 拖走判死
kill @e[tag=kitpvp.earth_pluto_carrier]
kill @e[tag=kitpvp.earth_pluto_parrot]
summon minecraft:zombie ~ ~ ~ {Tags:["kitpvp.earth_minion","kitpvp.earth_minion_new","kitpvp.earth_pluto","kitpvp.earth_pluto_carrier"],CustomName:'{"text":"冥王星","color":"dark_blue"}',CustomNameVisible:1b,Silent:1b,PersistenceRequired:1b,NoAI:1b,CanPickUpLoot:0b,Invisible:1b,Health:20.0f,Attributes:[{Name:"minecraft:generic.max_health",Base:20.0},{Name:"minecraft:generic.movement_speed",Base:0}],ArmorItems:[{},{id:"minecraft:leather_leggings",Count:1b},{},{}],HandItems:[{id:"minecraft:stone_sword",Count:1b},{}],Passengers:[{id:"minecraft:parrot",Tags:["kitpvp.earth_pluto_parrot"],CustomName:'{"text":"冥王星","color":"dark_blue"}',CustomNameVisible:1b,NoAI:1b,Silent:1b,PersistenceRequired:1b,Variant:4,Health:30.0f,Attributes:[{Name:"minecraft:generic.max_health",Base:30.0}]}]}
execute as @e[tag=kitpvp.earth_pluto_carrier] run effect give @s minecraft:resistance infinite 4 true
