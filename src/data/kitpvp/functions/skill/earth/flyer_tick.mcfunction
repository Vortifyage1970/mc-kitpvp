# 地球·69 飞行器：共生（吊舱死则母体死）+ 补绳 + 清掉地上的 lead + 每 10 秒俯冲 17 格
# 由 tick.mcfunction 以 as @e[tag=kitpvp.earth_flyer_carrier] at @s 调用
execute if score @s kitpvp.flyer_grace matches ..0 unless entity @e[tag=kitpvp.earth_flyer_body] run kill @s
execute if score @s kitpvp.flyer_grace matches 1.. run scoreboard players remove @s kitpvp.flyer_grace 1
execute as @e[tag=kitpvp.earth_flyer_body,tag=kitpvp.fl_slot_a] unless data entity @s Leash run data merge entity @s {Leash:{UUID:[I;1900010,1,1,1]}}
execute as @e[tag=kitpvp.earth_flyer_body,tag=kitpvp.fl_slot_b] unless data entity @s Leash run data merge entity @s {Leash:{UUID:[I;1900011,1,1,1]}}
execute as @e[tag=kitpvp.earth_flyer_body] at @s run kill @e[type=minecraft:item,nbt={Item:{id:"minecraft:lead"}},distance=..4]
# 俯冲目标：不是召唤者的最近玩家（用临时 tag 筛，免得把绳子往自己脸上甩）
scoreboard players operation #fl_own kitpvp.game = @s kitpvp.earth_owner
tag @a[tag=kitpvp.flyer_target] remove kitpvp.flyer_target
execute as @a[gamemode=!spectator,tag=!kitpvp.spectator,nbt=!{Health:0.0f}] unless score @s kitpvp.etid = #fl_own kitpvp.game run tag @s add kitpvp.flyer_target
# 每 200 刻（10 秒）扑一次，17 刻 × 1 格/刻
execute if score @s kitpvp.earth_cd_a matches ..0 run scoreboard players set @s kitpvp.flyer_dive 17
execute if score @s kitpvp.earth_cd_a matches ..0 run scoreboard players set @s kitpvp.earth_cd_a 200
execute if score @s kitpvp.flyer_dive matches 1.. facing entity @p[tag=kitpvp.flyer_target] feet run tp @s ^ ^ ^1
execute if score @s kitpvp.flyer_dive matches 1.. run scoreboard players remove @s kitpvp.flyer_dive 1
