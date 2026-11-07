# 罐子自测：召唤一只无主罐子 → 记下 10 格内生灵数 → 2 秒后用 damage 打死它（真实受伤路径）→ 再数一次
# 用法：/reload 后 /function kitpvp:debug/jar_test
tellraw @a [{"text":"[罐子测试] 召唤一只无主罐子，2 秒后用 damage 打死它","color":"gold"}]
execute as @p at @s run summon minecraft:zombie ~ ~ ~2 {Tags:["kitpvp.earth_jar","kitpvp.debug_jar"],CustomName:'{"text":"测试罐子","color":"gold"}',CustomNameVisible:1b,PersistenceRequired:1b,ArmorItems:[{},{},{},{id:"minecraft:decorated_pot",Count:1b}],HandItems:[{},{}]}
execute as @p at @s store result score #jt_before kitpvp.game if entity @e[tag=kitpvp.earth_minion,distance=..10]
tellraw @a [{"text":"[罐子测试] 死之前，10 格内生灵 = ","color":"gray"},{"score":{"name":"#jt_before","objective":"kitpvp.game"}}]
schedule function kitpvp:debug/jar_test_b 40t replace
