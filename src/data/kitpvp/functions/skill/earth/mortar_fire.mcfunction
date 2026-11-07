# @s = 迫击炮（at @s）：锁定"此刻"目标的站位，然后朝那个点扔一条鱼过去
# 关键：落点用 marker 记住，之后不再追人 —— 所以不会在头顶悬停，玩家跑开就躲得掉，这才是迫击炮
kill @e[tag=kitpvp.mo_aim]
execute at @p[tag=kitpvp.mo_tgt,limit=1] run summon minecraft:marker ~ ~ ~ {Tags:["kitpvp.mo_aim"]}
# 鱼弹要 NoAI + NoGravity + Invulnerable：不然它会自己游泳/掉进水里/被路过的人随手打掉
summon minecraft:cod ~ ~1.6 ~ {Tags:["kitpvp.mo_shell"],NoAI:1b,NoGravity:1b,Silent:1b,Invulnerable:1b,PersistenceRequired:1b,CustomName:'{"text":"鱼弹","color":"gray"}',CustomNameVisible:0b}
# 只给刚扔出去的这条：它在炮口，离炮最近
scoreboard players set @e[tag=kitpvp.mo_shell,limit=1,sort=nearest] kitpvp.mo_life 0
scoreboard players operation @e[tag=kitpvp.mo_shell,limit=1,sort=nearest] kitpvp.mo_owner = @s kitpvp.earth_owner
# 按距离装药：分七档，档内取"中距"算水平速度，误差控制在 ±1.5 格
# mo_vy = 竖直初速（每刻 -1），决定弧顶高度与滞空；mo_hs = 水平速度 ×100，按 滞空 × hs/100 ≈ 距离 配
# 先给默认值、再按档覆盖；档位边界用重叠写法（3..6 与 6..9 都含 6）。不然小数距离会掉进缝里，
# 一档都不匹配 -> vy/hs 保持 0 -> 鱼既不升也不走，直接往下掉
scoreboard players set @e[tag=kitpvp.mo_shell,limit=1,sort=nearest] kitpvp.mo_vy 8
scoreboard players set @e[tag=kitpvp.mo_shell,limit=1,sort=nearest] kitpvp.mo_hs 15
execute if entity @p[tag=kitpvp.mo_tgt,distance=3..6] run scoreboard players set @e[tag=kitpvp.mo_shell,limit=1,sort=nearest] kitpvp.mo_vy 9
execute if entity @p[tag=kitpvp.mo_tgt,distance=3..6] run scoreboard players set @e[tag=kitpvp.mo_shell,limit=1,sort=nearest] kitpvp.mo_hs 27
execute if entity @p[tag=kitpvp.mo_tgt,distance=6..9] run scoreboard players set @e[tag=kitpvp.mo_shell,limit=1,sort=nearest] kitpvp.mo_vy 11
execute if entity @p[tag=kitpvp.mo_tgt,distance=6..9] run scoreboard players set @e[tag=kitpvp.mo_shell,limit=1,sort=nearest] kitpvp.mo_hs 36
execute if entity @p[tag=kitpvp.mo_tgt,distance=9..12] run scoreboard players set @e[tag=kitpvp.mo_shell,limit=1,sort=nearest] kitpvp.mo_vy 12
execute if entity @p[tag=kitpvp.mo_tgt,distance=9..12] run scoreboard players set @e[tag=kitpvp.mo_shell,limit=1,sort=nearest] kitpvp.mo_hs 45
execute if entity @p[tag=kitpvp.mo_tgt,distance=12..15] run scoreboard players set @e[tag=kitpvp.mo_shell,limit=1,sort=nearest] kitpvp.mo_vy 14
execute if entity @p[tag=kitpvp.mo_tgt,distance=12..15] run scoreboard players set @e[tag=kitpvp.mo_shell,limit=1,sort=nearest] kitpvp.mo_hs 50
execute if entity @p[tag=kitpvp.mo_tgt,distance=15..18] run scoreboard players set @e[tag=kitpvp.mo_shell,limit=1,sort=nearest] kitpvp.mo_vy 16
execute if entity @p[tag=kitpvp.mo_tgt,distance=15..18] run scoreboard players set @e[tag=kitpvp.mo_shell,limit=1,sort=nearest] kitpvp.mo_hs 53
execute if entity @p[tag=kitpvp.mo_tgt,distance=18..] run scoreboard players set @e[tag=kitpvp.mo_shell,limit=1,sort=nearest] kitpvp.mo_vy 18
execute if entity @p[tag=kitpvp.mo_tgt,distance=18..] run scoreboard players set @e[tag=kitpvp.mo_shell,limit=1,sort=nearest] kitpvp.mo_hs 55
scoreboard players set @s kitpvp.earth_cd_a 60
playsound minecraft:entity.arrow.shoot hostile @a ~ ~ ~ 0.9 0.7
