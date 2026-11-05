# 木星探针 A：只召唤、不打它，看它能不能自己活下来
# 三次采样：立刻 / 3 刻后 / 20 刻后，每次打印"带 tag 的木星数"和"8 格内僵尸总数"
# 读法：tag 掉到 0 而僵尸数还在 = tag 被摘了；两者一起归 0 = 实体被删了；都还在 = 召唤没问题，锅在死亡判定
scoreboard players set #jp0 kitpvp.game 0
execute at @s run function kitpvp:summon/earth_jupiter
execute store result score #jp0 kitpvp.game if entity @e[tag=kitpvp.earth_jupiter]
tellraw @a [{"text":"[A-0] 召唤后 带tag木星数=","color":"gold"},{"score":{"name":"#jp0","objective":"kitpvp.game"}}]
schedule function kitpvp:debug/jupiter_probe2_a 3t replace
