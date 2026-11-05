# 木星探针 A 第 2 次采样（3 刻后）：不打它，只数
scoreboard players set #jp1 kitpvp.game 0
scoreboard players set #jz1 kitpvp.game 0
execute store result score #jp1 kitpvp.game if entity @e[tag=kitpvp.earth_jupiter]
execute store result score #jz1 kitpvp.game if entity @e[type=minecraft:zombie,distance=..8]
tellraw @a [{"text":"[A-1] 3 刻后 带tag木星数=","color":"gold"},{"score":{"name":"#jp1","objective":"kitpvp.game"}},{"text":"  8格内僵尸数=","color":"gray"},{"score":{"name":"#jz1","objective":"kitpvp.game"}}]
schedule function kitpvp:debug/jupiter_probe2_b 20t replace
