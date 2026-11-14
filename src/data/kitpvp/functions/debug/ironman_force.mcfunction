# [测试] 强制场上所有铁人立刻放一次炸弹（不等冷却）
execute as @e[tag=kitpvp.earth_ironman] at @s run function kitpvp:skill/earth/ironman_bomb
tellraw @a [{"text":"[铁人探针] 已强制所有铁人立刻放一次炸弹","color":"gold"}]
