# 尖牙测试（debug）：一尊"铁块骷髅"——头戴铁块、NoAI 站桩、完全静音，每 3 秒朝 15 格内最近的玩家放一次尖牙
# 再跑一次本函数 = 清掉旧的重新立一尊
# 20 血、不无敌：想测"被打断"就照打
kill @e[tag=kitpvp.fang_test]
kill @e[tag=kitpvp.fang_at]
kill @e[tag=kitpvp.fang_fake]
execute at @s run summon minecraft:skeleton ~ ~ ~ {Tags:["kitpvp.fang_test"],CustomName:'{"text":"尖牙祭坛","color":"light_purple"}',CustomNameVisible:1b,Silent:1b,NoAI:1b,PersistenceRequired:1b,CanPickUpLoot:0b,Health:20.0f,Attributes:[{Name:"minecraft:generic.max_health",Base:20.0}],HandItems:[{},{}],ArmorItems:[{},{},{},{id:"minecraft:iron_block",Count:1b}]}
scoreboard players set @e[tag=kitpvp.fang_test] kitpvp.fang_cd 20
schedule function kitpvp:debug/fang_test_loop 1t replace
tellraw @s [{"text":"[尖牙测试] 已立起：铁块头、不动、不响、20 血的骷髅，每 3 秒朝 15 格内最近的玩家放一发尖牙（伤害 2 点，自己结算）","color":"light_purple"}]
tellraw @s [{"text":"[尖牙测试] 结束请输入 /kill @e[tag=kitpvp.fang_test]","color":"gray"}]
