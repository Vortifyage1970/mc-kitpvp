# 地球·15 超凡升天：头戴玻璃、两手玻璃；3 秒后漂浮 V 15 秒，再 15 秒后清除
summon minecraft:zombie ~ ~ ~ {Tags:["kitpvp.earth_minion","kitpvp.earth_minion_new","kitpvp.earth_levitate"],CustomName:'{"text":"超凡升天","color":"aqua"}',CustomNameVisible:1b,PersistenceRequired:1b,CanPickUpLoot:0b,HandItems:[{id:"minecraft:glass",Count:1b},{id:"minecraft:glass",Count:1b}],ArmorItems:[{},{},{},{id:"minecraft:glass",Count:1b}]}
scoreboard players set @e[tag=kitpvp.earth_minion_new] kitpvp.earth_lev 60
