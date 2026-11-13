# 雪球测试（debug）：一尊铁块头骷髅，每 2 秒朝 15 格内最近的玩家丢一颗雪球（自己算弹道、自己结算 1 点伤害）
# 原版没有"会丢雪球的骷髅"：雪球只有玩家和雪傀儡会扔，而雪傀儡只打敌对生物、不打玩家。
# 所以这里全部用命令做：算方向 → summon 一颗带 Motion 的雪球 → 每刻检测命中 → 自己 damage
kill @e[tag=kitpvp.snow_test]
kill @e[type=minecraft:snowball,tag=kitpvp.snow]
execute at @s run summon minecraft:skeleton ~ ~ ~ {Tags:["kitpvp.snow_test"],CustomName:'{"text":"雪球祭坛","color":"aqua"}',CustomNameVisible:1b,Silent:1b,NoAI:1b,PersistenceRequired:1b,CanPickUpLoot:0b,Health:20.0f,Attributes:[{Name:"minecraft:generic.max_health",Base:20.0}],HandItems:[{},{}],ArmorItems:[{},{},{},{id:"minecraft:iron_block",Count:1b}]}
scoreboard players set @e[tag=kitpvp.snow_test] kitpvp.snow_cd 20
schedule function kitpvp:debug/snow_test_loop 1t replace
tellraw @s [{"text":"[雪球测试] 已立起：铁块头骷髅，每 2 秒朝 15 格内最近的玩家丢一颗雪球（1 点伤害，命令结算）","color":"aqua"}]
tellraw @s [{"text":"[雪球测试] 结束请输入 /kill @e[tag=kitpvp.snow_test]","color":"gray"}]
