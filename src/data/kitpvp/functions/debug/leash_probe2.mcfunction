summon minecraft:cow ~1 ~ ~ {UUID:[I;1900002,2,1,1],Leash:[I;1900002,1,1,1],Tags:["lt_cow"],CustomName:'{"text":"cow_leashed"}'}
summon minecraft:silverfish ~2 ~ ~ {UUID:[I;1900002,3,1,1],Leash:[I;1900002,1,1,1],Tags:["lt_fish"],CustomName:'{"text":"fish_leashed"}'}
tellraw @a [{"text":"[拴绳测试] 持有者 UUID = ","color":"gray"},{"nbt":"UUID","entity":"@e[tag=lt_holder,limit=1]","color":"yellow"}]
tellraw @a [{"text":"  牛 Leash = ","color":"gray"},{"nbt":"Leash","entity":"@e[tag=lt_cow,limit=1]","color":"aqua"}]
tellraw @a [{"text":"  蠹虫 Leash = ","color":"gray"},{"nbt":"Leash","entity":"@e[tag=lt_fish,limit=1]","color":"aqua"}]
tellraw @a [{"text":"= 牛有值说明机制本身能用；两只都空说明本环境不吃 NBT 拴绳","color":"dark_gray"}]
