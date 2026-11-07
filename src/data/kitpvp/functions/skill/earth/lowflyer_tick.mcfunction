# 地球·73 低空飞行器：一只普通的蝙蝠（原版怎么飞就怎么飞），下面用绳子吊着骷髅弓箭手
# 由 tick.mcfunction 以 as @e[tag=kitpvp.earth_lowflyer_carrier] at @s 调用
# 出生当刻不算共生：吊舱是 1 刻后才召的。用 tag 而不是计分（计分没 /reload 就不存在，会永远不判死）
execute unless entity @s[tag=kitpvp.lf_spawning] unless entity @e[tag=kitpvp.earth_lowflyer_body] run kill @s
tag @s remove kitpvp.lf_spawning
execute as @e[tag=kitpvp.earth_lowflyer_body] unless data entity @s Leash run data merge entity @s {Leash:{UUID:[I;1900011,1,1,1]}}
execute as @e[tag=kitpvp.earth_lowflyer_body] at @s run kill @e[type=minecraft:item,nbt={Item:{id:"minecraft:lead"}},distance=..4]
# 不追人、不悬停、不改高度：飞行完全交给原版蝙蝠 AI。
# 只有一件事要管——飘得太远（超过 16 格）就朝召唤者飞回去，否则它会自己钻进洞、挂墙上，看着像丢了
scoreboard players set #lf_own kitpvp.game -1
scoreboard players operation #lf_own kitpvp.game = @s kitpvp.earth_owner
tag @a[tag=kitpvp.lf_home] remove kitpvp.lf_home
execute as @a[gamemode=!spectator,tag=!kitpvp.spectator,nbt=!{Health:0.0f}] if score @s kitpvp.etid = #lf_own kitpvp.game run tag @s add kitpvp.lf_home
execute unless entity @p[tag=kitpvp.lf_home,distance=..16] if entity @p[tag=kitpvp.lf_home] at @s facing entity @p[tag=kitpvp.lf_home] feet run tp @s ^ ^ ^0.35
# 吊舱每刻贴到母体下方 1 格：原版持绳超过约 10 格就 dropLeash，飘远了绳子会断、骷髅留在半空
execute at @s run tp @e[tag=kitpvp.earth_lowflyer_body] ~ ~-1 ~
