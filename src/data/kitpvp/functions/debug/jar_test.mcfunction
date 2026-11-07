# 罐子自测：召唤一只无主罐子 → 立刻数它 → 2 秒后用 damage 打死它（真实受伤路径）→ 再数
# 用法：/reload 后 /function kitpvp:debug/jar_test
tellraw @a [{"text":"[罐子测试] 召唤一只无主罐子，2 秒后用 damage 打死它","color":"gold"}]
execute as @p at @s run summon minecraft:zombie ~ ~ ~2 {Tags:["kitpvp.earth_jar","kitpvp.debug_jar"],CustomName:'{"text":"测试罐子","color":"gold"}',CustomNameVisible:1b,PersistenceRequired:1b,ArmorItems:[{},{},{},{id:"minecraft:decorated_pot",Count:1b}],HandItems:[{},{}]}
scoreboard players set #jt_sum kitpvp.game 0
execute store result score #jt_sum kitpvp.game if entity @e[tag=kitpvp.debug_jar]
scoreboard players set #jt_hp kitpvp.game -1
execute store result score #jt_hp kitpvp.game run data get entity @e[tag=kitpvp.debug_jar,limit=1] Health
execute as @p at @s store result score #jt_before kitpvp.game if entity @e[tag=kitpvp.earth_minion,distance=..10]
tellraw @a [{"text":"[罐子测试] 召唤后：罐子 = ","color":"gray"},{"score":{"name":"#jt_sum","objective":"kitpvp.game"}},{"text":"  Health = ","color":"gray"},{"score":{"name":"#jt_hp","objective":"kitpvp.game"}},{"text":"  10 格内生灵 = ","color":"gray"},{"score":{"name":"#jt_before","objective":"kitpvp.game"}}]
schedule function kitpvp:debug/jar_test_b 40t replace
