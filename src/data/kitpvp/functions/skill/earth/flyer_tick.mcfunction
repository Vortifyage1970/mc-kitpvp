# 地球·69 飞行器：共生（吊舱死则母体死）+ 补绳 + 清掉落 lead + 限高 + 追击 + 每 10 秒俯冲 25 格
# 由 tick.mcfunction 以 as @e[tag=kitpvp.earth_flyer_carrier] at @s 调用
# ---- 吊舱：没出来就补召，已经出来过才走"共生" ----
# flyer_bound=1 表示"吊舱真的出生过"，之后它消失才判母体死；没出生过就重试，避免"要召两次"
execute if entity @e[tag=kitpvp.earth_flyer_body] run scoreboard players set @s kitpvp.flyer_bound 1
execute if score @s kitpvp.flyer_grace matches 1.. run scoreboard players remove @s kitpvp.flyer_grace 1
execute if score @s kitpvp.flyer_bound matches 1 unless entity @e[tag=kitpvp.earth_flyer_body] run kill @s
execute if score @s kitpvp.flyer_bound matches ..0 if score @s kitpvp.flyer_grace matches ..0 unless entity @e[tag=kitpvp.earth_flyer_body] run function kitpvp:summon/earth_flyer_b
execute if score @s kitpvp.flyer_bound matches ..0 if score @s kitpvp.flyer_grace matches ..0 unless entity @e[tag=kitpvp.earth_flyer_body] run scoreboard players set @s kitpvp.flyer_grace 10
execute as @e[tag=kitpvp.earth_flyer_body] unless data entity @s Leash run data merge entity @s {Leash:{UUID:[I;1900010,1,1,1]}}
execute as @e[tag=kitpvp.earth_flyer_body] at @s run kill @e[type=minecraft:item,nbt={Item:{id:"minecraft:lead"}},distance=..4]
# ---- 索敌：优先"非召唤者"；只剩召唤者在线时退化为最近的玩家 ----
scoreboard players operation #fl_own kitpvp.game = @s kitpvp.earth_owner
tag @a[tag=kitpvp.flyer_target] remove kitpvp.flyer_target
execute as @a[gamemode=!spectator,tag=!kitpvp.spectator,nbt=!{Health:0.0f}] unless score @s kitpvp.etid = #fl_own kitpvp.game run tag @s add kitpvp.flyer_target
execute unless entity @a[tag=kitpvp.flyer_target] as @a[gamemode=!spectator,tag=!kitpvp.spectator] run tag @s add kitpvp.flyer_target
# ---- 追击：离目标超过 20 格就主动贴过去（否则它只在原地盘旋，看着像"不索敌"）----
execute if entity @a[tag=kitpvp.flyer_target] if entity @p[tag=kitpvp.flyer_target,tag=!kitpvp.spectator,distance=20..] facing entity @p[tag=kitpvp.flyer_target] feet run tp @s ^ ^ ^1
# ---- 限高：最多比目标玩家高 6 格 ----
execute at @p[tag=kitpvp.flyer_target] as @e[tag=kitpvp.earth_flyer_carrier,dy=6..] at @s run tp @s ~ ~-1 ~
# ---- 每 200 刻（10 秒）扑一次，25 刻 × 1 格/刻 ----
execute if score @s kitpvp.earth_cd_a matches ..0 run scoreboard players set @s kitpvp.flyer_dive 25
execute if score @s kitpvp.earth_cd_a matches ..0 run scoreboard players set @s kitpvp.earth_cd_a 200
execute if score @s kitpvp.flyer_dive matches 1.. if entity @a[tag=kitpvp.flyer_target] facing entity @p[tag=kitpvp.flyer_target] feet run tp @s ^ ^ ^1
execute if score @s kitpvp.flyer_dive matches 1.. unless entity @a[tag=kitpvp.flyer_target] run tp @s ~ ~-1 ~
# 俯冲期间把吊舱一起搬走（原版生物持绳 >10 格必断，25 格冲刺靠拽是不可能不断的）
execute if score @s kitpvp.flyer_dive matches 1.. at @s run tp @e[tag=kitpvp.earth_flyer_body,limit=1,sort=nearest] ~ ~-2 ~
execute if score @s kitpvp.flyer_dive matches 1.. run scoreboard players remove @s kitpvp.flyer_dive 1
