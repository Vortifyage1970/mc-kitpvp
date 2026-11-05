# 木星探针 A 第 3 次采样（20 刻后）：还是不打它
scoreboard players set #jp2 kitpvp.game 0
scoreboard players set #jz2 kitpvp.game 0
execute store result score #jp2 kitpvp.game if entity @e[tag=kitpvp.earth_jupiter]
execute store result score #jz2 kitpvp.game if entity @e[type=minecraft:zombie,distance=..8]
tellraw @a [{"text":"[A-2] 20 刻后 带tag木星数=","color":"gold"},{"score":{"name":"#jp2","objective":"kitpvp.game"}},{"text":"  8格内僵尸数=","color":"gray"},{"score":{"name":"#jz2","objective":"kitpvp.game"}}]
tellraw @a [{"text":"判读：全 1 → 召唤正常，锅在死亡判定；tag=0 而僵尸≥1 → 标签被摘；两个都 0 → 实体被删（有东西在杀召唤物）","color":"dark_gray"}]
