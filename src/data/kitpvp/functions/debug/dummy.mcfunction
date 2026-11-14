# 训练假人：先在正前方 3 格生成，再用 spreadplayers 把它"放"到附近地面上
# 直接按 ^ ^ ^3 生成的话，前面是墙/斜坡时僵尸会卡进方块里（窒息/看不见）
execute at @s run summon minecraft:zombie ^ ^ ^3 {Tags:["kitpvp.debug_dummy","kitpvp.debug_dummy_new"],CustomName:'{"text":"训练假人","color":"gray"}',CustomNameVisible:1b,PersistenceRequired:1b,Health:30f,Attributes:[{Name:"minecraft:generic.max_health",Base:30.0}],ArmorItems:[{id:"minecraft:iron_boots",Count:1b},{id:"minecraft:iron_leggings",Count:1b},{id:"minecraft:iron_chestplate",Count:1b},{id:"minecraft:iron_helmet",Count:1b}]}
execute at @s run spreadplayers ~ ~ 1 4 false @e[tag=kitpvp.debug_dummy_new]
tag @e[tag=kitpvp.debug_dummy_new] remove kitpvp.debug_dummy_new
tellraw @s [{"text":"[debug] ","color":"light_purple","bold":true},{"text":"已在身旁生成训练假人（30 血铁套僵尸）","color":"white"}]
