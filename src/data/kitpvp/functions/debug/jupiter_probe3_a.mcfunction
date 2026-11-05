# 木星探针 B 第 2 次采样（打死 1 刻后）：尸体、雷、已放雷标记各数一次
scoreboard players set #kd1 kitpvp.game 0
scoreboard players set #kz1 kitpvp.game 0
scoreboard players set #kl1 kitpvp.game 0
scoreboard players set #ks1 kitpvp.game 0
execute store result score #kd1 kitpvp.game if entity @e[tag=kitpvp.earth_jupiter]
execute store result score #kz1 kitpvp.game if entity @e[type=minecraft:zombie,distance=..8]
execute store result score #kl1 kitpvp.game if entity @e[type=minecraft:lightning_bolt]
execute store result score #ks1 kitpvp.game if entity @e[tag=kitpvp.earth_jupiter_struck]
tellraw @a [{"text":"[B-1] 1 刻后 带tag木星=","color":"gold"},{"score":{"name":"#kd1","objective":"kitpvp.game"}},{"text":" 僵尸=","color":"gray"},{"score":{"name":"#kz1","objective":"kitpvp.game"}},{"text":" 雷=","color":"gray"},{"score":{"name":"#kl1","objective":"kitpvp.game"}},{"text":" 已放雷=","color":"gray"},{"score":{"name":"#ks1","objective":"kitpvp.game"}}]
execute as @e[tag=kitpvp.earth_jupiter] run tellraw @a [{"text":"  尸体 hp 分=","color":"gray"},{"score":{"name":"@s","objective":"kitpvp.earth_hp"}},{"text":"  Pos=","color":"gray"},{"nbt":"Pos","entity":"@s"}]
