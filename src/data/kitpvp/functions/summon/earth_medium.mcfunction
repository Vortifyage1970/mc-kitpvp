# 地球·44 介质：三只完全隐形的僵尸，常驻虚弱 X（近战伤害被压成 0）+ 抗性 V（普通伤害全免）
# Invisible:1b 让本体不可见；手上不拿东西、不穿甲，所以没有任何"破绽"露出来
# 三只一起出场，等于三个看不见的活靶子（血量各 20）
summon minecraft:zombie ~ ~ ~ {Tags:["kitpvp.earth_minion","kitpvp.earth_minion_new","kitpvp.earth_medium"],Invisible:1b,PersistenceRequired:1b,CanPickUpLoot:0b,Silent:1b}
summon minecraft:zombie ~ ~1 ~ {Tags:["kitpvp.earth_minion","kitpvp.earth_minion_new","kitpvp.earth_medium"],Invisible:1b,PersistenceRequired:1b,CanPickUpLoot:0b,Silent:1b}
summon minecraft:zombie ~ ~2 ~ {Tags:["kitpvp.earth_minion","kitpvp.earth_minion_new","kitpvp.earth_medium"],Invisible:1b,PersistenceRequired:1b,CanPickUpLoot:0b,Silent:1b}
effect give @e[tag=kitpvp.earth_medium] minecraft:weakness infinite 9 true
effect give @e[tag=kitpvp.earth_medium] minecraft:resistance infinite 4 true