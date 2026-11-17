# 低空飞行器的"吊舱"：由 summon/earth_lowflyer_a 排程 1 刻后调用，锚在蝙蝠身上
# 不带 earth_minion_new：它比母体晚一帧出生，不该被"下一次召唤"的 link 领走（会被记成别人的召唤物）
# 上一具骷髅要播完死亡动画才消失，这期间它的 UUID 还占着 ⇒ 同一 UUID 再 summon 会被静默丢掉，所以每刻重试
execute if entity @e[tag=kitpvp.earth_lowflyer_carrier,limit=1] unless entity @e[tag=kitpvp.earth_lowflyer_body,nbt=!{Health:0.0f}] at @e[tag=kitpvp.earth_lowflyer_carrier,limit=1,sort=nearest] run summon minecraft:skeleton ~ ~-1.5 ~ {UUID:[I;1900011,2,1,1],Tags:["kitpvp.earth_minion","kitpvp.earth_lowflyer","kitpvp.earth_lowflyer_body","kitpvp.lf_body_new"],Leash:{UUID:[I;1900011,1,1,1]},NoGravity:1b,Silent:1b,PersistenceRequired:1b,CanPickUpLoot:0b,CustomName:'{"text":"低空飞行器","color":"dark_aqua"}',CustomNameVisible:1b,HandItems:[{id:"minecraft:bow",Count:1b},{}],ArmorItems:[{id:"minecraft:leather_boots",Count:1b,tag:{Unbreakable:1b,display:{color:16777215},Enchantments:[{id:"minecraft:feather_falling",lvl:20}]}},{},{},{id:"minecraft:white_wool",Count:1b}]}
# ★ 吊舱：无重力 + 有 AI —— 箭交给原版骷髅自己射
# "不打召唤者"靠队伍：原版 AI 的目标筛选会跳过队友，所以它必须和召唤者进同一队
# 归属从蝙蝠身上继承（蝙蝠的 earth_owner 是 earth_lowflyer_a 里按 #lf_owner 写死的），认的是刚出生的那只
scoreboard players operation @e[tag=kitpvp.lf_body_new] kitpvp.earth_owner = @e[tag=kitpvp.earth_lowflyer_carrier,limit=1,sort=nearest] kitpvp.earth_owner
execute if entity @e[tag=kitpvp.lf_body_new,scores={kitpvp.earth_owner=1}] run team join earth_1 @e[tag=kitpvp.lf_body_new]
execute if entity @e[tag=kitpvp.lf_body_new,scores={kitpvp.earth_owner=2}] run team join earth_2 @e[tag=kitpvp.lf_body_new]
execute if entity @e[tag=kitpvp.lf_body_new,scores={kitpvp.earth_owner=3}] run team join earth_3 @e[tag=kitpvp.lf_body_new]
execute if entity @e[tag=kitpvp.lf_body_new,scores={kitpvp.earth_owner=4}] run team join earth_4 @e[tag=kitpvp.lf_body_new]
execute if entity @e[tag=kitpvp.lf_body_new,scores={kitpvp.earth_owner=5}] run team join earth_5 @e[tag=kitpvp.lf_body_new]
execute if entity @e[tag=kitpvp.lf_body_new,scores={kitpvp.earth_owner=6}] run team join earth_6 @e[tag=kitpvp.lf_body_new]
tag @e[tag=kitpvp.lf_body_new] remove kitpvp.lf_body_new
# 召出来了 ⇒ 清空重试预算，lowflyer_tick 的"落单判死"从这一刻起生效（骷髅死了蝙蝠才跟着死）
execute if entity @e[tag=kitpvp.earth_lowflyer_body,nbt=!{Health:0.0f}] run scoreboard players set #lf_body_wait kitpvp.game 0
# 没召出来 ⇒ 每刻重试，最多 20 刻（预算用完 lowflyer_tick 会把这只蝙蝠判死，不留半成品）
execute unless entity @e[tag=kitpvp.earth_lowflyer_body,nbt=!{Health:0.0f}] if score #lf_body_wait kitpvp.game matches 1.. run schedule function kitpvp:summon/earth_lowflyer_b 1t replace
execute unless entity @e[tag=kitpvp.earth_lowflyer_body,nbt=!{Health:0.0f}] if score #lf_body_wait kitpvp.game matches 1.. run scoreboard players remove #lf_body_wait kitpvp.game 1
