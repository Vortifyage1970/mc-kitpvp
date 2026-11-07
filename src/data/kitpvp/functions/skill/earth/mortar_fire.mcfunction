# @s = 迫击炮（at @s）：从炮口扔一条鱼，鱼自己带着向上的初速飞出去
# 鱼弹要 NoAI + NoGravity + Invulnerable：不然它会自己游泳/掉进水里/被路过的人随手打掉
summon minecraft:cod ~ ~1.6 ~ {Tags:["kitpvp.mo_shell"],NoAI:1b,NoGravity:1b,Silent:1b,Invulnerable:1b,PersistenceRequired:1b,CustomName:'{"text":"鱼弹","color":"gray"}',CustomNameVisible:0b}
# 只给刚扔出去的这条：它在炮口，离炮最近
scoreboard players set @e[tag=kitpvp.mo_shell,limit=1,sort=nearest] kitpvp.mo_vy 12
scoreboard players set @e[tag=kitpvp.mo_shell,limit=1,sort=nearest] kitpvp.mo_life 0
scoreboard players operation @e[tag=kitpvp.mo_shell,limit=1,sort=nearest] kitpvp.mo_owner = @s kitpvp.earth_owner
scoreboard players set @s kitpvp.earth_cd_a 60
playsound minecraft:entity.arrow.shoot hostile @a ~ ~ ~ 0.9 0.7
