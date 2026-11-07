# 罐子自测：召唤一只无主罐子 → 2 秒后 kill 它 → 5 刻后报 10 格内的生灵数
# 用法：/reload 后 /function kitpvp:debug/jar_test
tellraw @a [{"text":"[罐子测试] 召唤一只无主罐子，2 秒后打死它","color":"gold"}]
execute as @p at @s run summon minecraft:zombie ~ ~ ~2 {Tags:["kitpvp.earth_jar","kitpvp.debug_jar"],CustomName:'{"text":"测试罐子","color":"gold"}',CustomNameVisible:1b,PersistenceRequired:1b,ArmorItems:[{},{},{},{id:"minecraft:decorated_pot",Count:1b}],HandItems:[{},{}]}
execute store result score #jt_n kitpvp.game if entity @e[tag=kitpvp.debug_jar]
tellraw @a [{"text":"[罐子测试] 场上的测试罐子 = ","color":"gray"},{"score":{"name":"#jt_n","objective":"kitpvp.game"}}]
schedule function kitpvp:debug/jar_test_b 40t replace
