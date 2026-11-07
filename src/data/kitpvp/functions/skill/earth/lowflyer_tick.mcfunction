# 地球·73 低空飞行器：一只普通蝙蝠拴着一只骷髅弓箭手，纯原版绳，脚本不挪任何一格
# 由 tick.mcfunction 以 as @e[tag=kitpvp.earth_lowflyer_carrier] at @s 调用
# 出生当刻不算共生：吊舱是 1 刻后才召的。用 tag 而不是计分（计分没 /reload 就不存在，会永远不判死）
execute unless entity @s[tag=kitpvp.lf_spawning] unless entity @e[tag=kitpvp.earth_lowflyer_body] run kill @s
tag @s remove kitpvp.lf_spawning
# 绳子断了就接回去（玩家/生物被打时会掉绳）
execute as @e[tag=kitpvp.earth_lowflyer_body] unless data entity @s Leash run data merge entity @s {Leash:{UUID:[I;1900011,1,1,1]}}
# 捡到手里的 lead 物品是断绳留下的垃圾，就地清掉
execute as @e[tag=kitpvp.earth_lowflyer_body] at @s run kill @e[type=minecraft:item,nbt={Item:{id:"minecraft:lead"}},distance=..4]
