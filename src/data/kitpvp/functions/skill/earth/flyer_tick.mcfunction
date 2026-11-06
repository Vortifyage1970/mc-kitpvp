# 地球·69 飞行器：共生（吊舱死则母体死）+ 补绳 + 清掉地上的 lead + 每 10 秒俯冲一次（扑到人跟前为止）
# 由 tick.mcfunction 以 as @e[tag=kitpvp.earth_flyer_carrier] at @s 调用
# ---- 共生：宽限 10 刻内不判（吊舱是下一帧才出生的）----
execute if score @s kitpvp.flyer_grace matches ..0 unless entity @e[tag=kitpvp.earth_flyer_body] run kill @s
execute if score @s kitpvp.flyer_grace matches 1.. run scoreboard players remove @s kitpvp.flyer_grace 1
execute as @e[tag=kitpvp.earth_flyer_body] unless data entity @s Leash run data merge entity @s {Leash:{UUID:[I;1900010,1,1,1]}}
execute as @e[tag=kitpvp.earth_flyer_body] at @s run kill @e[type=minecraft:item,nbt={Item:{id:"minecraft:lead"}},distance=..4]
# ---- 选目标：优先"不是召唤者"的玩家；只有召唤者在线时退化为召唤者本人 ----
#      （以前只筛"非召唤者"，单机测试时一个目标都没有 ⇒ facing 失败 ⇒ tp 那句根本不执行，
#        看到的就是"像飘下来 / 扑一半停住"，因为下降全靠幻翼自己的 AI）
scoreboard players operation #fl_own kitpvp.game = @s kitpvp.earth_owner
tag @a[tag=kitpvp.flyer_target] remove kitpvp.flyer_target
execute as @a[gamemode=!spectator,tag=!kitpvp.spectator,nbt=!{Health:0.0f}] unless score @s kitpvp.etid = #fl_own kitpvp.game run tag @s add kitpvp.flyer_target
execute unless entity @a[tag=kitpvp.flyer_target] as @p[gamemode=!spectator,tag=!kitpvp.spectator] run tag @s add kitpvp.flyer_target
# ---- 每 200 刻（10 秒）起一次俯冲：1 格/刻，最多 40 刻，但"离目标还远就续命"，扑到 6 格内才停 ----
execute if score @s kitpvp.earth_cd_a matches ..0 run scoreboard players set @s kitpvp.flyer_dive 40
execute if score @s kitpvp.earth_cd_a matches ..0 run scoreboard players set @s kitpvp.earth_cd_a 200
execute if score @s kitpvp.flyer_dive matches 1.. facing entity @p[tag=kitpvp.flyer_target] feet run tp @s ^ ^ ^1
execute if score @s kitpvp.flyer_dive matches 1.. if entity @a[tag=kitpvp.flyer_target,distance=6..] run scoreboard players set @s kitpvp.flyer_dive 6
execute if score @s kitpvp.flyer_dive matches 1.. run scoreboard players remove @s kitpvp.flyer_dive 1
