# 木星探针 B（改）：召唤 + 按 tag 打死（不再用 type=zombie 过滤），并检查它到底是不是僵尸
scoreboard players set #kd0 kitpvp.game 0
scoreboard players set #kt0 kitpvp.game 0
execute at @s run function kitpvp:summon/earth_jupiter
execute store result score #kd0 kitpvp.game if entity @e[tag=kitpvp.earth_jupiter]
execute store result score #kt0 kitpvp.game if entity @e[tag=kitpvp.earth_jupiter,type=minecraft:zombie]
tellraw @a [{"text":"[B-0] 召唤后 带tag木星=","color":"gold"},{"score":{"name":"#kd0","objective":"kitpvp.game"}},{"text":" 其中是僵尸的=","color":"gold"},{"score":{"name":"#kt0","objective":"kitpvp.game"}}]
execute as @e[tag=kitpvp.earth_jupiter] run tellraw @a [{"text":"  召唤后 hp 分=","color":"gray"},{"score":{"name":"@s","objective":"kitpvp.earth_hp"}}]
damage @e[tag=kitpvp.earth_jupiter,distance=..6,sort=nearest,limit=1] 100
tellraw @a [{"text":"[B-1] 已下 damage 100（按 tag 选目标），1 刻后自动采样","color":"gold"}]
schedule function kitpvp:debug/jupiter_probe3_a 1t replace
