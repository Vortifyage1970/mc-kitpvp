# 低空飞行器的"吊舱"：由 summon/earth_lowflyer_a 排程 1 刻后调用，锚在蝙蝠身上
# 不带 earth_minion_new：它比母体晚一帧出生，不该被"下一次召唤"的 link 领走（会被记成别人的召唤物）
# 上一具骷髅要播完死亡动画才消失，这期间它的 UUID 还占着 ⇒ 同一 UUID 再 summon 会被静默丢掉，所以每刻重试
execute if entity @e[tag=kitpvp.earth_lowflyer_carrier,limit=1] unless entity @e[tag=kitpvp.earth_lowflyer_body,nbt=!{Health:0.0f}] at @e[tag=kitpvp.earth_lowflyer_carrier,limit=1,sort=nearest] run summon minecraft:skeleton ~ ~-1.5 ~ {UUID:[I;1900011,2,1,1],Tags:["kitpvp.earth_minion","kitpvp.earth_lowflyer","kitpvp.earth_lowflyer_body","kitpvp.lf_body_new"],Leash:{UUID:[I;1900011,1,1,1]},NoGravity:1b,Silent:1b,PersistenceRequired:1b,CanPickUpLoot:0b,Health:12.0f,Attributes:[{Name:"minecraft:generic.max_health",Base:12.0}],CustomName:'{"text":"低空飞行器","color":"dark_aqua"}',CustomNameVisible:1b,HandItems:[{id:"minecraft:bow",Count:1b},{}],ArmorItems:[{id:"minecraft:leather_boots",Count:1b,tag:{Unbreakable:1b,display:{color:16777215},Enchantments:[{id:"minecraft:feather_falling",lvl:20}]}},{},{},{id:"minecraft:white_wool",Count:1b}]}
# ★ 吊舱：无重力 + 有 AI —— 箭交给原版骷髅自己射
# "不打召唤者"靠队伍：原版 AI 只看队友，所以它必须和召唤者进同一队。
# 队伍直接从蝙蝠身上抄（蝙蝠已经在 earth_a 里按召唤者并好队了），6 行试完即止 —— 不依赖任何计分
execute as @e[tag=kitpvp.earth_lowflyer_carrier,team=earth_1,limit=1] run team join earth_1 @e[tag=kitpvp.lf_body_new]
execute as @e[tag=kitpvp.earth_lowflyer_carrier,team=earth_2,limit=1] run team join earth_2 @e[tag=kitpvp.lf_body_new]
execute as @e[tag=kitpvp.earth_lowflyer_carrier,team=earth_3,limit=1] run team join earth_3 @e[tag=kitpvp.lf_body_new]
execute as @e[tag=kitpvp.earth_lowflyer_carrier,team=earth_4,limit=1] run team join earth_4 @e[tag=kitpvp.lf_body_new]
execute as @e[tag=kitpvp.earth_lowflyer_carrier,team=earth_5,limit=1] run team join earth_5 @e[tag=kitpvp.lf_body_new]
execute as @e[tag=kitpvp.earth_lowflyer_carrier,team=earth_6,limit=1] run team join earth_6 @e[tag=kitpvp.lf_body_new]
# 归属分数从蝙蝠抄（写不上不影响"不打召唤者"）
scoreboard players operation @e[tag=kitpvp.lf_body_new] kitpvp.earth_owner = @e[tag=kitpvp.earth_lowflyer_carrier,limit=1,sort=nearest] kitpvp.earth_owner
tag @e[tag=kitpvp.lf_body_new] remove kitpvp.lf_body_new
# 召出来了 ⇒ 清空重试预算，lowflyer_tick 的"落单判死"从这一刻起生效（骷髅死了蝙蝠才跟着死）
execute if entity @e[tag=kitpvp.earth_lowflyer_body,nbt=!{Health:0.0f}] run scoreboard players set #lf_body_wait kitpvp.game 0
# 没召出来 ⇒ 每刻重试，最多 20 刻（预算用完 lowflyer_tick 会把这只蝙蝠判死，不留半成品）
execute unless entity @e[tag=kitpvp.earth_lowflyer_body,nbt=!{Health:0.0f}] if score #lf_body_wait kitpvp.game matches 1.. run schedule function kitpvp:summon/earth_lowflyer_b 1t replace
execute unless entity @e[tag=kitpvp.earth_lowflyer_body,nbt=!{Health:0.0f}] if score #lf_body_wait kitpvp.game matches 1.. run scoreboard players remove #lf_body_wait kitpvp.game 1
