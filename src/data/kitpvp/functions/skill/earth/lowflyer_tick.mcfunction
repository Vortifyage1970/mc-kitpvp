# 地球·73 低空飞行器：蝙蝠不吃重力、自己飞，骷髅吊在它正下方 1.5 格（每刻对齐），箭由脚本点名射
# 由 tick.mcfunction 以 as @e[tag=kitpvp.earth_lowflyer_carrier] at @s 调用
# 出生当刻不算共生：吊舱是 1 刻后才召的。用 tag 而不是计分（计分没 /reload 就不存在，会永远不判死）
execute unless entity @s[tag=kitpvp.lf_spawning] unless entity @e[tag=kitpvp.earth_lowflyer_body] run kill @s
tag @s remove kitpvp.lf_spawning
# 绳子断了就接回去（玩家/生物被打时会掉绳）
execute as @e[tag=kitpvp.earth_lowflyer_body] unless data entity @s Leash run data merge entity @s {Leash:{UUID:[I;1900011,1,1,1]}}
# 吊舱是 NoAI + NoGravity：蝙蝠自己飞，骷髅每刻被拉回蝙蝠正下方 1.5 格，绳子永远够不着断的 10 格
execute at @s run tp @e[tag=kitpvp.earth_lowflyer_body,distance=..12] ~ ~-1.5 ~
# 捡到手里的 lead 物品是断绳留下的垃圾，就地清掉
execute as @e[tag=kitpvp.earth_lowflyer_body] at @s run kill @e[type=minecraft:item,nbt={Item:{id:"minecraft:lead"}},distance=..4]
# 吊舱的射击：骷髅本身 NoAI（原版 AI 分不出召唤者），每 2 秒由 lowflyer_shoot 点名射一发
execute as @e[tag=kitpvp.earth_lowflyer_body,scores={kitpvp.earth_cd_a=..0}] at @s run function kitpvp:skill/earth/lowflyer_shoot
