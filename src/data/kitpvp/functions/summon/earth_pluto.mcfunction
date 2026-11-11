# 地球·80 冥王星：隐形的抗性提升 V 尸壳，头顶钉着一只 30 血的鹦鹉（和「冥王星」职业同款：鹦鹉 NoAI、每刻被 tp 到头顶，不是乘客）
# 用尸壳（husk）：1.20.1 里会走会打的亡灵只有尸壳白天不烧（流浪者、骷髅、僵尸都烧），它隐形所以外观没差别
# 会自己走、会打人，所以不写 NoAI、也不压移速；名字留空
# 鹦鹉一死，尸壳跟着死；尸壳没了，鹦鹉也不留（见 skill/earth/pluto_tick）
# 鹦鹉钉在头顶 2.5 格（不是 2 格）：平砍壳子身体时挥不到它，得抬头或跳起来点才能打掉血条
# 鹦鹉刻意不带 kitpvp.pluto_parrot —— 那个 tag 是「冥王星职业」分身的，串上会被它的 follow/check 拖走判死
kill @e[tag=kitpvp.earth_pluto_carrier]
kill @e[tag=kitpvp.earth_pluto_parrot]
scoreboard players add #pluto_pair kitpvp.game 1
summon minecraft:husk ~ ~ ~ {Tags:["kitpvp.earth_minion","kitpvp.earth_minion_new","kitpvp.earth_pluto","kitpvp.earth_pluto_carrier","kitpvp.pl_new"],Silent:1b,PersistenceRequired:1b,CanPickUpLoot:0b,Invisible:1b,Health:20.0f,Attributes:[{Name:"minecraft:generic.max_health",Base:20.0}],ArmorItems:[{},{id:"minecraft:leather_leggings",Count:1b},{},{}],HandItems:[{id:"minecraft:stone_sword",Count:1b},{}]}
summon minecraft:parrot ~ ~2.5 ~ {Tags:["kitpvp.earth_pluto_parrot","kitpvp.pl_new"],CustomName:'{"text":"冥王星","color":"dark_blue"}',CustomNameVisible:1b,NoAI:1b,Silent:1b,PersistenceRequired:1b,Variant:4,Health:30.0f,Attributes:[{Name:"minecraft:generic.max_health",Base:30.0}]}
scoreboard players operation @e[tag=kitpvp.pl_new] kitpvp.pluto_pair = #pluto_pair kitpvp.game
scoreboard players set @e[tag=kitpvp.pl_new] kitpvp.pluto_miss 0
tag @e[tag=kitpvp.pl_new] remove kitpvp.pl_new
execute as @e[tag=kitpvp.earth_pluto_carrier] run effect give @s minecraft:invisibility infinite 0 true
execute as @e[tag=kitpvp.earth_pluto_carrier] run effect give @s minecraft:resistance infinite 4 true
# 尸壳（外壳）常驻虚弱 I：近战伤害砍半，靠"打不动人、但抗性 V 也打不死"占点
execute as @e[tag=kitpvp.earth_pluto_carrier] run effect give @s minecraft:weakness infinite 0 true
