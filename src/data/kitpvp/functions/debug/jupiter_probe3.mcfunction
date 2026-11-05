# 木星探针 B：召唤 + 用 /damage 打死，然后在**1 刻后**看尸体（死亡动画有 20 刻，1 刻后必然还在）
scoreboard players set #kd0 kitpvp.game 0
execute at @s run function kitpvp:summon/earth_jupiter
damage @e[type=minecraft:zombie,tag=kitpvp.earth_jupiter,distance=..3,sort=nearest,limit=1] 100 minecraft:generic
execute store result score #kd0 kitpvp.game if entity @e[tag=kitpvp.earth_jupiter]
tellraw @a [{"text":"[B-0] 打死那一瞬间 带tag木星数=","color":"gold"},{"score":{"name":"#kd0","objective":"kitpvp.game"}}]
schedule function kitpvp:debug/jupiter_probe3_a 1t replace
