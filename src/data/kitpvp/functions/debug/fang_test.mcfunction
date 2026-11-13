# 尖牙测试（debug）：一尊"铁块骷髅"——头戴铁块、NoAI 站桩、完全静音，每 3 秒朝 15 格内最近的玩家放一次唤魔者尖牙
# 再跑一次本函数 = 清掉旧的重新立一尊
kill @e[tag=kitpvp.fang_test]
kill @e[tag=kitpvp.fang_at]
execute at @s run summon minecraft:skeleton ~ ~ ~ {Tags:["kitpvp.fang_test"],CustomName:'{"text":"尖牙祭坛","color":"light_purple"}',CustomNameVisible:1b,Silent:1b,NoAI:1b,Invulnerable:1b,PersistenceRequired:1b,CanPickUpLoot:0b,HandItems:[{},{}],ArmorItems:[{},{},{},{id:"minecraft:iron_block",Count:1b}]}
scoreboard players set @e[tag=kitpvp.fang_test] kitpvp.fang_cd 20
schedule function kitpvp:debug/fang_test_loop 1t replace
tellraw @s [{"text":"[尖牙测试] 已立起：头戴铁块、不动、不响的骷髅，每 3 秒朝 15 格内最近的玩家放一发尖牙","color":"light_purple"}]
tellraw @s [{"text":"[尖牙测试] 站到它面前 15 格内即可；结束请输入 /kill @e[tag=kitpvp.fang_test]","color":"gray"}]
