# 地球·69 飞行器：共生（吊舱死则母体死）+ 补绳 + 清掉地上的 lead + 每 10 秒俯冲 17 格
# 由 tick.mcfunction 以 as @e[tag=kitpvp.earth_flyer_carrier] at @s 调用
# 出生当刻不算共生：吊舱是 1 刻后才召的。用 tag 而不是计分（计分没 /reload 就不存在，会永远不判死）
execute unless entity @s[tag=kitpvp.fl_spawning] unless entity @e[tag=kitpvp.earth_flyer_body] run kill @s
tag @s remove kitpvp.fl_spawning
execute as @e[tag=kitpvp.earth_flyer_body] unless data entity @s Leash run data merge entity @s {Leash:{UUID:[I;1900010,1,1,1]}}
execute as @e[tag=kitpvp.earth_flyer_body] at @s run kill @e[type=minecraft:item,nbt={Item:{id:"minecraft:lead"}},distance=..4]
# 俯冲目标：不是召唤者的最近玩家（用临时 tag 筛，免得把绳子往自己脸上甩）
scoreboard players operation #fl_own kitpvp.game = @s kitpvp.earth_owner
tag @a[tag=kitpvp.flyer_target] remove kitpvp.flyer_target
execute as @a[gamemode=!spectator,tag=!kitpvp.spectator,nbt=!{Health:0.0f}] unless score @s kitpvp.etid = #fl_own kitpvp.game run tag @s add kitpvp.flyer_target
# 每 200 刻（10 秒）扑一次，17 刻 × 1 格/刻
execute if score @s kitpvp.earth_cd_a matches ..0 run scoreboard players set @s kitpvp.flyer_dive 17
execute if score @s kitpvp.earth_cd_a matches ..0 run scoreboard players set @s kitpvp.earth_cd_a 200
# ★ 吊舱跟着一起下：原版持绳超过约 10 格就 dropLeash，17 格俯冲必然闪断 ⇒ 骷髅留在半空、够不到人
#   每刻先把它贴到母体下方 1 格，两者距离永远 <2（绳子不断、骷髅也不会被落下），母体再往前挪 1 格
execute if score @s kitpvp.flyer_dive matches 1.. run tp @e[tag=kitpvp.earth_flyer_body] ~ ~-1 ~
execute if score @s kitpvp.flyer_dive matches 1.. facing entity @p[tag=kitpvp.flyer_target] feet run tp @s ^ ^ ^1
execute if score @s kitpvp.flyer_dive matches 1.. run scoreboard players remove @s kitpvp.flyer_dive 1
