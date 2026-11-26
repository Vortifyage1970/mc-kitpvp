# 8 x 1in2 拼 0..255，再对 20 取模；余 0 即触发（13/256 ≈ 5.08%，最接近"5%"的整数写法）
scoreboard players set @s kitpvp.cz_rng 0
execute if predicate kitpvp:random/1in2 run scoreboard players add @s kitpvp.cz_rng 1
execute if predicate kitpvp:random/1in2 run scoreboard players add @s kitpvp.cz_rng 2
execute if predicate kitpvp:random/1in2 run scoreboard players add @s kitpvp.cz_rng 4
execute if predicate kitpvp:random/1in2 run scoreboard players add @s kitpvp.cz_rng 8
execute if predicate kitpvp:random/1in2 run scoreboard players add @s kitpvp.cz_rng 16
execute if predicate kitpvp:random/1in2 run scoreboard players add @s kitpvp.cz_rng 32
execute if predicate kitpvp:random/1in2 run scoreboard players add @s kitpvp.cz_rng 64
execute if predicate kitpvp:random/1in2 run scoreboard players add @s kitpvp.cz_rng 128
# 辞令状态期间（tag kitpvp.cz_buff）概率翻倍：5% -> 10%
execute if entity @s[tag=kitpvp.cz_buff] run scoreboard players operation @s kitpvp.cz_rng %= #cz10 kitpvp.game
execute unless entity @s[tag=kitpvp.cz_buff] run scoreboard players operation @s kitpvp.cz_rng %= #cz20 kitpvp.game
execute if score @s kitpvp.cz_rng matches 0 run function kitpvp:skill/zhuzhiwu/pull
