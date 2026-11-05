# 木星探针第 2 段（由 jupiter_probe 排 2 刻后执行）：把尸体状态打到聊天框
tellraw @a [{"text":"=== 2 刻后的状态 ===","color":"gold"}]
execute as @e[tag=kitpvp.earth_jupiter] run tellraw @a [{"text":"  尸体还在：hp=","color":"gray"},{"score":{"name":"@s","objective":"kitpvp.earth_hp"}},{"text":"  已放雷=","color":"gray"},{"selector":"@s[tag=kitpvp.earth_jupiter_struck]"}]
tellraw @a [{"text":"  现存雷电实体：","color":"gray"},{"selector":"@e[type=minecraft:lightning_bolt]"}]
tellraw @a [{"text":"  读法：没有“尸体还在”那行 = 尸体已被移除/没打死；hp=0 但没 struck = tick 判定没命中；有 struck 没雷 = summon 雷失败","color":"dark_gray"}]
