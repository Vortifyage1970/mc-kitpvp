# 地球·75 铁人：标准僵尸（原版 AI、原版数值，不带任何状态效果／属性改写）
# 只保留：名字 + 外观（皮革套染色 + 铁块当头） + 炸弹节拍需要的 im_cd
summon minecraft:zombie ~ ~ ~ {Tags:["kitpvp.earth_minion","kitpvp.earth_minion_new","kitpvp.earth_ironman"],CustomName:'{"text":"铁人","color":"aqua"}',CustomNameVisible:1b,PersistenceRequired:1b,CanPickUpLoot:0b,HandItems:[{},{}],ArmorItems:[{id:"minecraft:leather_boots",Count:1b,tag:{display:{color:14721056}}},{id:"minecraft:leather_leggings",Count:1b,tag:{display:{color:12598571}}},{id:"minecraft:leather_chestplate",Count:1b,tag:{display:{color:12598571}}},{id:"minecraft:iron_block",Count:1b}]}
scoreboard players set @e[tag=kitpvp.earth_ironman] kitpvp.im_cd 100
