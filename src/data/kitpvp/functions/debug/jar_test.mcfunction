# 罐子自测：走正式召唤函数召一只罐子（带脚下守卫 marker）→ 2 秒后 damage 打死它 → 数新生
# 用法：/reload 后 /function kitpvp:debug/jar_test
tellraw @a [{"text":"[罐子测试] 召唤一只罐子（带守卫 marker），2 秒后用 damage 打死它","color":"gold"}]
execute as @p at @s run function kitpvp:summon/earth_jar
scoreboard players set #jt_sum kitpvp.game 0
execute store result score #jt_sum kitpvp.game if entity @e[tag=kitpvp.earth_jar]
scoreboard players set #jt_guard kitpvp.game 0
execute store result score #jt_guard kitpvp.game if entity @e[tag=kitpvp.earth_jar_guard]
execute as @p at @s store result score #jt_before kitpvp.game if entity @e[tag=kitpvp.earth_minion,distance=..10]
tellraw @a [{"text":"[罐子测试] 召唤后：罐子 = ","color":"gray"},{"score":{"name":"#jt_sum","objective":"kitpvp.game"}},{"text":"  守卫 = ","color":"gray"},{"score":{"name":"#jt_guard","objective":"kitpvp.game"}},{"text":"  10 格内生灵 = ","color":"gray"},{"score":{"name":"#jt_before","objective":"kitpvp.game"}}]
schedule function kitpvp:debug/jar_test_b 40t replace
