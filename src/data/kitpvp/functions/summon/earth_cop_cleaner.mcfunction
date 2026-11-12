# 地球·30 交警（查车版）：出场方式沿用第 29 只（矿车、双手末地烛、车 10 秒后撤），常驻速度 II
# 不带头部的力量与车内抗性 —— 这一只只要求"速度 3"；脑袋和胸口换成绿色皮革（原来是磁石头，2026-11-12 作者要求）
# 唯一的区别是出场那一刻：先把半径 50 格内所有矿车和船清场，再造自己的车。
# 顺序不能反：先造车再清场会把自己那辆车一起干掉（自己的车也带 earth_cop_cart 标签、也在 50 格内）
# 不碰 chest_minecart，也不碰挂了 kitpvp.displayitem 的实体：地图布置里的展示矿车不能被拆
kill @e[type=minecraft:minecart,distance=..50,tag=!kitpvp.displayitem]
kill @e[type=minecraft:boat,distance=..50,tag=!kitpvp.displayitem]

# 下面三行与 earth_cop 同一套写法，只是标签换成 cleaner 版、不带力量/抗性；车沿用 earth_cop_cart，tick 里那条倒计时 kill 直接复用
summon minecraft:minecart ~ ~ ~ {Tags:["kitpvp.earth_mount","kitpvp.earth_cop_cart"],Invulnerable:1b,Passengers:[{id:"minecraft:zombie",Tags:["kitpvp.earth_minion","kitpvp.earth_minion_new","kitpvp.earth_cop_cleaner"],CustomName:'{"text":"交警","color":"yellow"}',CustomNameVisible:1b,PersistenceRequired:1b,CanPickUpLoot:0b,Health:15.0f,Attributes:[{Name:"minecraft:generic.max_health",Base:15.0}],HandItems:[{id:"minecraft:end_rod",Count:1b},{id:"minecraft:end_rod",Count:1b}],ArmorItems:[{},{},{id:"minecraft:leather_chestplate",Count:1b,tag:{display:{color:52224}}},{id:"minecraft:leather_helmet",Count:1b,tag:{display:{color:52224}}}]}]}
scoreboard players set @e[tag=kitpvp.earth_cop_cart] kitpvp.earth_cd_a 200
effect give @e[tag=kitpvp.earth_cop_cleaner] minecraft:speed infinite 1 true
