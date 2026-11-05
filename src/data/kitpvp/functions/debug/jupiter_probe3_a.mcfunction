# 木星探针 B 第 2 段（damage 后 1 刻）：看尸体还在不在、hp 是不是 0、雷有没有出来
scoreboard players set #kd1 kitpvp.game 0
scoreboard players set #kl1 kitpvp.game 0
scoreboard players set #ks1 kitpvp.game 0
execute store result score #kd1 kitpvp.game if entity @e[tag=kitpvp.earth_jupiter]
execute store result score #kl1 kitpvp.game if entity @e[type=minecraft:lightning_bolt]
execute store result score #ks1 kitpvp.game if entity @e[tag=kitpvp.earth_jupiter_struck]
tellraw @a [{"text":"[B-2] 1 刻后 带tag木星=","color":"gold"},{"score":{"name":"#kd1","objective":"kitpvp.game"}},{"text":" 雷=","color":"gray"},{"score":{"name":"#kl1","objective":"kitpvp.game"}},{"text":" 已放雷=","color":"gray"},{"score":{"name":"#ks1","objective":"kitpvp.game"}}]
execute as @e[tag=kitpvp.earth_jupiter] run tellraw @a [{"text":"  尸体 hp 分=","color":"gray"},{"score":{"name":"@s","objective":"kitpvp.earth_hp"}}]
