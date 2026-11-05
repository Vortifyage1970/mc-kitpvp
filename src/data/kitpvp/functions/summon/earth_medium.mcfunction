# 地球·44 介质（指令名 medium）：三只完全隐形的尸壳（husk），常驻虚弱 X（近战伤害压成 0）+ 抗性 V（普通伤害全免）+ 缓慢 I
# 三只都叫「介质」（CustomNameVisible:0b ⇒ 名字不挂在头顶，隐身才藏得住）
# 尸壳（husk）在白天不会自燃，隐身之后靠盔甲/粒子也看不出来；Invisible:1b 让本体不可见；手上不拿东西、不穿甲，所以没有任何"破绽"露出来
# 三只一起出场，等于三个看不见的活靶子（血量各 20）
# 静音：连"生灵已降临"那声草地音也不响（本体 Sound 已由 Silent 关掉，这行管的是召唤播报）
scoreboard players set #summon_quiet kitpvp.game 1
summon minecraft:husk ~ ~ ~ {Tags:["kitpvp.earth_minion","kitpvp.earth_minion_new","kitpvp.earth_medium"],Invisible:1b,ArmorItems:[{},{},{},{}],HandItems:[{},{}],CustomName:'{"text":"介质","color":"gray"}',CustomNameVisible:0b,PersistenceRequired:1b,CanPickUpLoot:0b,Silent:1b}
summon minecraft:husk ~ ~1 ~ {Tags:["kitpvp.earth_minion","kitpvp.earth_minion_new","kitpvp.earth_medium"],Invisible:1b,ArmorItems:[{},{},{},{}],HandItems:[{},{}],CustomName:'{"text":"介质","color":"gray"}',CustomNameVisible:0b,PersistenceRequired:1b,CanPickUpLoot:0b,Silent:1b}
summon minecraft:husk ~ ~2 ~ {Tags:["kitpvp.earth_minion","kitpvp.earth_minion_new","kitpvp.earth_medium"],Invisible:1b,ArmorItems:[{},{},{},{}],HandItems:[{},{}],CustomName:'{"text":"介质","color":"gray"}',CustomNameVisible:0b,PersistenceRequired:1b,CanPickUpLoot:0b,Silent:1b}
effect give @e[tag=kitpvp.earth_medium] minecraft:weakness infinite 9 true
effect give @e[tag=kitpvp.earth_medium] minecraft:resistance infinite 4 true
effect give @e[tag=kitpvp.earth_medium] minecraft:slowness infinite 0 true