# 低空飞行器状态探针：站在刚召出来的那对旁边运行 /function kitpvp:debug/lf_state
# 只读，不改任何东西；看完可以删
execute store result score #lf_n1 kitpvp.game if entity @e[tag=kitpvp.earth_lowflyer_carrier]
execute store result score #lf_n2 kitpvp.game if entity @e[tag=kitpvp.earth_lowflyer_body]
tellraw @a {"text":"=== 低空飞行器状态 ===","color":"gold"}
tellraw @a [{"text":"我：etid=","color":"gray"},{"score":{"name":"@s","objective":"kitpvp.etid"},"color":"white"},{"text":"｜队伍=","color":"gray"},{"nbt":"Team","entity":"@s"}]
tellraw @a [{"text":"#lf_owner=","color":"gray"},{"score":{"name":"#lf_owner","objective":"kitpvp.game"},"color":"white"},{"text":"｜#lf_wait=","color":"gray"},{"score":{"name":"#lf_wait","objective":"kitpvp.game"},"color":"white"},{"text":"｜#lf_body_wait=","color":"gray"},{"score":{"name":"#lf_body_wait","objective":"kitpvp.game"},"color":"white"}]
tellraw @a [{"text":"蝙蝠数＝","color":"gray"},{"score":{"name":"#lf_n1","objective":"kitpvp.game"},"color":"white"},{"text":"｜骷髅数＝","color":"gray"},{"score":{"name":"#lf_n2","objective":"kitpvp.game"},"color":"white"}]
execute if entity @e[tag=kitpvp.earth_lowflyer_carrier,limit=1] run tellraw @a [{"text":"蝙蝠：队伍=","color":"aqua"},{"nbt":"Team","entity":"@e[tag=kitpvp.earth_lowflyer_carrier,limit=1]"}]
execute if entity @e[tag=kitpvp.earth_lowflyer_carrier,limit=1] run tellraw @a [{"text":"蝙蝠：earth_owner=","color":"aqua"},{"score":{"name":"@e[tag=kitpvp.earth_lowflyer_carrier,limit=1]","objective":"kitpvp.earth_owner"},"color":"white"}]
execute if entity @e[tag=kitpvp.earth_lowflyer_body,limit=1] run tellraw @a [{"text":"骷髅：队伍=","color":"aqua"},{"nbt":"Team","entity":"@e[tag=kitpvp.earth_lowflyer_body,limit=1]"}]
execute if entity @e[tag=kitpvp.earth_lowflyer_body,limit=1] run tellraw @a [{"text":"骷髅：earth_owner=","color":"aqua"},{"score":{"name":"@e[tag=kitpvp.earth_lowflyer_body,limit=1]","objective":"kitpvp.earth_owner"},"color":"white"}]
