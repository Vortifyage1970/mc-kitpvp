# 用法：先 /give @s minecraft:lead 拿拴绳，手动拴住身边一只生物（牛/羊都行），再跑本函数
# 目的：读"真人手动拴出来的"那只的 NBT，确认 1.20.1 里这个字段到底叫什么、存的是什么
tellraw @a [{"text":"[拴绳对照] 站到你手动拴住的那只生物 8 格内再跑一次","color":"yellow"}]
tellraw @a [{"text":"  最近生物类型 = ","color":"gray"},{"nbt":"id","entity":"@e[type=!minecraft:player,limit=1,sort=nearest,distance=..8]","color":"aqua"}]
tellraw @a [{"text":"  它的 Leash  = ","color":"gray"},{"nbt":"Leash","entity":"@e[type=!minecraft:player,limit=1,sort=nearest,distance=..8]","color":"aqua"}]
tellraw @a [{"text":"  它的 Leashed= ","color":"gray"},{"nbt":"Leashed","entity":"@e[type=!minecraft:player,limit=1,sort=nearest,distance=..8]","color":"aqua"}]
tellraw @a [{"text":"= 手动拴的那只有值 ⇒ 字段名对、只是 /summon 时不被接受；三个都空 ⇒ 站得太远或没拴上","color":"dark_gray"}]
