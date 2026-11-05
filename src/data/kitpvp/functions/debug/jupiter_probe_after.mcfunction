# 木星探针第 2 段（jupiter_probe 排 2 刻后执行）：尸体状态 + 是否已经放过雷
scoreboard players set #jup_after kitpvp.game 0
execute store success score #jup_after kitpvp.game if entity @e[tag=kitpvp.earth_jupiter]
tellraw @a [{"text":"[探针] 2 刻后 尸体数(#jup_after)=","color":"gray"},{"score":{"name":"#jup_after","objective":"kitpvp.game"}},{"text":"  已放雷=","color":"gray"},{"selector":"@e[tag=kitpvp.earth_jupiter_struck]"},{"text":"  雷=","color":"gray"},{"selector":"@e[type=minecraft:lightning_bolt]"}]
execute as @e[tag=kitpvp.earth_jupiter] run tellraw @a [{"text":"  尸体 hp=","color":"gray"},{"score":{"name":"@s","objective":"kitpvp.earth_hp"}}]
