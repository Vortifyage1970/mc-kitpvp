# @s = 反装甲步兵（at 它身上）：开一炮
# 状态切换：装填 60 -> -60（60 刻的跑位窗口），这一帧摘掉缓慢 III、给 60 刻速度 I
scoreboard players set @s kitpvp.at_charge -60
effect clear @s minecraft:slowness
effect give @s minecraft:speed 60 0 true

# 落点：开炮那一刻目标脚下放 marker，之后不再追人 —— 和迫击炮同一套"打提前量"手感，只是弹速快得多
kill @e[tag=kitpvp.at_aim]
execute at @p[tag=kitpvp.at_tgt,limit=1,sort=nearest] run summon minecraft:marker ~ ~0.2 ~ {Tags:["kitpvp.at_aim"]}

# 炮弹：火弹外观的 item 实体，NoGravity + 无敌 + 不可拾取，靠 antitank_shell_tick 每刻推 1.2 格
summon minecraft:item ~ ~1.6 ~ {Tags:["kitpvp.at_shell"],Item:{id:"minecraft:fire_charge",Count:1b},NoGravity:1b,Silent:1b,Invulnerable:1b,PersistenceRequired:1b,PickupDelay:32767s,Age:0s}
scoreboard players operation @e[tag=kitpvp.at_shell,limit=1,sort=nearest] kitpvp.at_owner = @s kitpvp.earth_owner
scoreboard players set @e[tag=kitpvp.at_shell,limit=1,sort=nearest] kitpvp.at_life 0

playsound minecraft:entity.blaze.shoot hostile @a ~ ~ ~ 1.0 0.6
playsound minecraft:item.firecharge.use hostile @a ~ ~ ~ 1.2 0.8
