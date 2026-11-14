# 训练假人：在正前方 3 格生成一只铁套僵尸（30 血、会动但没有 AI 关闭）
execute at @s run summon minecraft:zombie ^ ^ ^3 {Tags:["kitpvp.debug_dummy"],CustomName:'{"text":"训练假人","color":"gray"}',CustomNameVisible:1b,PersistenceRequired:1b,Health:30f,Attributes:[{Name:"minecraft:generic.max_health",Base:30.0}],ArmorItems:[{id:"minecraft:iron_boots",Count:1b},{id:"minecraft:iron_leggings",Count:1b},{id:"minecraft:iron_chestplate",Count:1b},{id:"minecraft:iron_helmet",Count:1b}]}
tellraw @s [{"text":"[debug] ","color":"light_purple","bold":true},{"text":"已在身旁 3 格生成训练假人（30 血铁套僵尸）","color":"white"}]
