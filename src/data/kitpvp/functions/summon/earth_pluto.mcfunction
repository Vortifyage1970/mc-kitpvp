# 地球·80 冥王星：隐形的抗性提升 V 流浪者，头顶钉着一只 30 血的鹦鹉（和「冥王星」职业同款：鹦鹉 NoAI、每刻被 tp 到头顶，不是乘客）
# 卫道士但不给斧头（手上一把石剑）：会自己走、会打人，所以不写 NoAI、也不压移速；名字留空
# 鹦鹉一死，卫道士跟着死；卫道士没了，鹦鹉也不留（见 skill/earth/pluto_tick）
# 鹦鹉刻意不带 kitpvp.pluto_parrot —— 那个 tag 是「冥王星职业」分身的，串上会被它的 follow/check 拖走判死
kill @e[tag=kitpvp.earth_pluto_carrier]
kill @e[tag=kitpvp.earth_pluto_parrot]
scoreboard players add #pluto_pair kitpvp.game 1
summon minecraft:vindicator ~ ~ ~ {Tags:["kitpvp.earth_minion","kitpvp.earth_minion_new","kitpvp.earth_pluto","kitpvp.earth_pluto_carrier","kitpvp.pl_new"],Silent:1b,PersistenceRequired:1b,CanPickUpLoot:0b,Invisible:1b,Health:20.0f,Attributes:[{Name:"minecraft:generic.max_health",Base:20.0}],ArmorItems:[{},{id:"minecraft:leather_leggings",Count:1b},{},{}],HandItems:[{id:"minecraft:stone_sword",Count:1b},{}]}
summon minecraft:parrot ~ ~2 ~ {Tags:["kitpvp.earth_pluto_parrot","kitpvp.pl_new"],CustomName:'{"text":"冥王星","color":"dark_blue"}',CustomNameVisible:1b,NoAI:1b,Silent:1b,PersistenceRequired:1b,Variant:4,Health:30.0f,Attributes:[{Name:"minecraft:generic.max_health",Base:30.0}]}
scoreboard players operation @e[tag=kitpvp.pl_new] kitpvp.pluto_pair = #pluto_pair kitpvp.game
scoreboard players set @e[tag=kitpvp.pl_new] kitpvp.pluto_miss 0
tag @e[tag=kitpvp.pl_new] remove kitpvp.pl_new
execute as @e[tag=kitpvp.earth_pluto_carrier] run effect give @s minecraft:resistance infinite 4 true
