# @s = 迫击炮（at @s）：锁定"此刻"目标的站位，然后朝那个点扔一条鱼过去
# 关键：落点用 marker 记住，之后不再追人 —— 所以不会在头顶悬停，玩家跑开就躲得掉，这才是迫击炮
kill @e[tag=kitpvp.mo_aim]
execute at @p[tag=kitpvp.mo_tgt,limit=1] run summon minecraft:marker ~ ~ ~ {Tags:["kitpvp.mo_aim"]}
# 鱼弹要 NoAI + NoGravity + Invulnerable：不然它会自己游泳/掉进水里/被路过的人随手打掉
summon minecraft:cod ~ ~1.6 ~ {Tags:["kitpvp.mo_shell"],NoAI:1b,NoGravity:1b,Silent:1b,Invulnerable:1b,PersistenceRequired:1b,CustomName:'{"text":"鱼弹","color":"gray"}',CustomNameVisible:0b}
# 只给刚扔出去的这条：它在炮口，离炮最近
scoreboard players set @e[tag=kitpvp.mo_shell,limit=1,sort=nearest] kitpvp.mo_life 0
scoreboard players operation @e[tag=kitpvp.mo_shell,limit=1,sort=nearest] kitpvp.mo_owner = @s kitpvp.earth_owner
# 按距离装药：近用小号（弧低、落得快），远用大号（弧高、飞得远）
# mo_vy = 竖直初速（每刻 -1），决定弧顶高度与滞空；mo_hs = 水平速度 ×100，按 滞空 × hs/100 ≈ 距离 配
execute if entity @p[tag=kitpvp.mo_tgt,distance=..7] run scoreboard players set @e[tag=kitpvp.mo_shell,limit=1,sort=nearest] kitpvp.mo_vy 7
execute if entity @p[tag=kitpvp.mo_tgt,distance=..7] run scoreboard players set @e[tag=kitpvp.mo_shell,limit=1,sort=nearest] kitpvp.mo_hs 42
execute if entity @p[tag=kitpvp.mo_tgt,distance=7..12] run scoreboard players set @e[tag=kitpvp.mo_shell,limit=1,sort=nearest] kitpvp.mo_vy 9
execute if entity @p[tag=kitpvp.mo_tgt,distance=7..12] run scoreboard players set @e[tag=kitpvp.mo_shell,limit=1,sort=nearest] kitpvp.mo_hs 55
execute if entity @p[tag=kitpvp.mo_tgt,distance=12..16] run scoreboard players set @e[tag=kitpvp.mo_shell,limit=1,sort=nearest] kitpvp.mo_vy 10
execute if entity @p[tag=kitpvp.mo_tgt,distance=12..16] run scoreboard players set @e[tag=kitpvp.mo_shell,limit=1,sort=nearest] kitpvp.mo_hs 68
execute if entity @p[tag=kitpvp.mo_tgt,distance=16..] run scoreboard players set @e[tag=kitpvp.mo_shell,limit=1,sort=nearest] kitpvp.mo_vy 12
execute if entity @p[tag=kitpvp.mo_tgt,distance=16..] run scoreboard players set @e[tag=kitpvp.mo_shell,limit=1,sort=nearest] kitpvp.mo_hs 82
scoreboard players set @s kitpvp.earth_cd_a 60
playsound minecraft:entity.arrow.shoot hostile @a ~ ~ ~ 0.9 0.7
