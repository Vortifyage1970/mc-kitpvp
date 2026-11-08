# @s = 反装甲步兵（at 它身上）：打出唯一的一炮
# 打完就定型：at_shot 1、缓慢 III 摘掉、永久速度 I（之后不再装填、不再开炮）
scoreboard players set @s kitpvp.at_shot 1
scoreboard players set @s kitpvp.at_charge 0
effect clear @s minecraft:slowness
effect give @s minecraft:speed infinite 0 true

# 落点：开炮那一刻目标脚下放 marker，之后不再追人 —— 和迫击炮同一套"打提前量"手感，只是弹速快得多
# 不清旧 marker：两只步兵同时开炮时，清掉会把前一颗还在飞的炮弹的落点弄没；
# 炮弹按"离自己最近的 marker"找落点，炸的时候也只收自己那颗
execute at @p[tag=kitpvp.at_tgt,limit=1,sort=nearest] run summon minecraft:marker ~ ~0.2 ~ {Tags:["kitpvp.at_aim"]}

# 炮弹：火弹外观的 item 实体，NoGravity + 无敌 + 不可拾取，靠 antitank_shell_tick 每刻推 1.2 格
summon minecraft:item ~ ~1.6 ~ {Tags:["kitpvp.at_shell"],Item:{id:"minecraft:fire_charge",Count:1b},NoGravity:1b,Silent:1b,Invulnerable:1b,PersistenceRequired:1b,PickupDelay:32767s,Age:0s}
scoreboard players operation @e[tag=kitpvp.at_shell,limit=1,sort=nearest] kitpvp.at_owner = @s kitpvp.earth_owner
scoreboard players set @e[tag=kitpvp.at_shell,limit=1,sort=nearest] kitpvp.at_life 0

playsound minecraft:entity.blaze.shoot hostile @a ~ ~ ~ 1.0 0.6
playsound minecraft:item.firecharge.use hostile @a ~ ~ ~ 1.2 0.8
