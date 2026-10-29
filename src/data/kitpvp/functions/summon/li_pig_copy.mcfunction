# 200 血的复制体：第 3 秒由 copy_stage 在每只 iLsacuL 原地召唤
execute if entity @s[tag=kitpvp.earth_ilsacul] run summon minecraft:pig ~ ~ ~ {Tags:["kitpvp.li_pig","kitpvp.earth_ilsacul","kitpvp.earth_minion","kitpvp.li_pig_copy_new"],CustomName:'{"text":"iLsacuL","color":"light_purple"}',CustomNameVisible:1b,PersistenceRequired:1b,Health:200.0f,Attributes:[{Name:"minecraft:generic.max_health",Base:200.0}]}
execute unless entity @s[tag=kitpvp.earth_ilsacul] run summon minecraft:pig ~ ~ ~ {Tags:["kitpvp.li_pig","kitpvp.li_pig_copy_new"],CustomName:'{"text":"iLsacuL","color":"light_purple"}',CustomNameVisible:1b,PersistenceRequired:1b,Health:200.0f,Attributes:[{Name:"minecraft:generic.max_health",Base:200.0}]}
execute if entity @s[tag=kitpvp.earth_ilsacul,team=earth_1] run team join earth_1 @e[tag=kitpvp.li_pig_copy_new]
execute if entity @s[tag=kitpvp.earth_ilsacul,team=earth_2] run team join earth_2 @e[tag=kitpvp.li_pig_copy_new]
execute if entity @s[tag=kitpvp.earth_ilsacul,team=earth_3] run team join earth_3 @e[tag=kitpvp.li_pig_copy_new]
execute if entity @s[tag=kitpvp.earth_ilsacul,team=earth_4] run team join earth_4 @e[tag=kitpvp.li_pig_copy_new]
execute if entity @s[tag=kitpvp.earth_ilsacul,team=earth_5] run team join earth_5 @e[tag=kitpvp.li_pig_copy_new]
execute if entity @s[tag=kitpvp.earth_ilsacul,team=earth_6] run team join earth_6 @e[tag=kitpvp.li_pig_copy_new]
tag @e[tag=kitpvp.li_pig_copy_new] remove kitpvp.li_pig_copy_new
