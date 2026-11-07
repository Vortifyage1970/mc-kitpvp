# 地球·57 ？？？（id: hydrator）：头戴法国国旗的僵尸，深蓝胸甲 / 白色护腿 / 红色靴子，常驻速度 II
# 死亡时在脚下灌一格水，并在聊天栏喊一句「补水啦」（靠脚下的守卫 marker 判定死活，见 skill/earth/hydrator_death）
# 为什么不用"读尸体 Health"：本机实测尸体不到 1 刻就消失，读不到那一帧（木星踩过的坑）
# 头盔是国旗骨头：盖上方块头白天不自燃
summon minecraft:zombie ~ ~ ~ {Tags:["kitpvp.earth_minion","kitpvp.earth_minion_new","kitpvp.earth_hydrator"],CustomName:'{"text":"？？？","color":"blue"}',CustomNameVisible:1b,PersistenceRequired:1b,CanPickUpLoot:0b,Health:15.0f,Attributes:[{Name:"minecraft:generic.max_health",Base:15.0}],HandItems:[{},{}],ArmorItems:[{id:"minecraft:leather_boots",Count:1b,tag:{display:{color:11546150}}},{id:"minecraft:leather_leggings",Count:1b,tag:{display:{color:16383998}}},{id:"minecraft:leather_chestplate",Count:1b,tag:{display:{color:1846923}}},{id:"minecraft:player_head",Count:1b,tag:{SkullOwner:{Id:[I;962222495,-1786228766,-1381431347,-2128205418],Properties:{textures:[{Value:"eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvNTEyNjlhMDY3ZWUzN2U2MzYzNWNhMWU3MjNiNjc2ZjEzOWRjMmRiZGRmZjk2YmJmZWY5OWQ4YjM1Yzk5NmJjIn19fQ=="}]}}}}]}
summon minecraft:marker ~ ~ ~ {Tags:["kitpvp.earth_hydrator_guard"]}
effect give @e[tag=kitpvp.earth_hydrator] minecraft:speed infinite 1 true
