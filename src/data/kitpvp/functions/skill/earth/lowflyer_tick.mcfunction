# 地球·73 低空飞行器：蝙蝠正常 AI + 重力，骷髅无重力 + 有 AI，靠原版拴绳跟着蝙蝠
# 由 tick.mcfunction 以 as @e[tag=kitpvp.earth_lowflyer_carrier] at @s 调用
# 出生当刻不算共生：吊舱是 1 刻后才召的。用 tag 而不是计分（计分没 /reload 就不存在，会永远不判死）
# 吊舱还在重试（#lf_body_wait 有正数预算）时也不判死，否则蝙蝠会在骷髅召出来的前一帧被自己杀掉
# 用 "unless 预算为正" 而不是 "if 预算为 0"：假玩家分数不存在时后者永远不成立（1.20.1 的老坑）
execute unless entity @s[tag=kitpvp.lf_spawning] unless score #lf_body_wait kitpvp.game matches 1.. unless entity @e[tag=kitpvp.earth_lowflyer_body] run kill @s
tag @s remove kitpvp.lf_spawning
# 绳子断了就接回去（玩家/生物被打时会掉绳）
execute as @e[tag=kitpvp.earth_lowflyer_body] unless data entity @s Leash run data merge entity @s {Leash:{UUID:[I;1900011,1,1,1]}}
# 位置交给原版拴绳：绳子把它拖着走，不再每刻 tp
# 捡到手里的 lead 物品是断绳留下的垃圾，就地清掉
execute as @e[tag=kitpvp.earth_lowflyer_body] at @s run kill @e[type=minecraft:item,nbt={Item:{id:"minecraft:lead"}},distance=..4]
# 射击交回原版骷髅 AI；不打召唤者靠队伍（earth_N 同队即跳过）
