# 低空飞行器的"吊舱"：由 summon/earth_lowflyer_a 排程 1 刻后调用，锚在蝙蝠身上
# 不带 earth_minion_new：它比母体晚一帧出生，不该被"下一次召唤"的 link 领走（会被记成别人的召唤物）
execute at @e[tag=kitpvp.earth_lowflyer_carrier,limit=1,sort=nearest] run summon minecraft:skeleton ~ ~1 ~ {UUID:[I;1900011,2,1,1],Tags:["kitpvp.earth_minion","kitpvp.earth_lowflyer","kitpvp.earth_lowflyer_body"],Leash:{UUID:[I;1900011,1,1,1]},NoAI:1b,NoGravity:1b,Silent:1b,PersistenceRequired:1b,CanPickUpLoot:0b,CustomName:'{"text":"低空飞行器","color":"dark_aqua"}',CustomNameVisible:1b,HandItems:[{id:"minecraft:bow",Count:1b},{}],ArmorItems:[{id:"minecraft:leather_boots",Count:1b,tag:{Unbreakable:1b,display:{color:16777215},Enchantments:[{id:"minecraft:feather_falling",lvl:20}]}},{},{},{id:"minecraft:white_wool",Count:1b}]}
# 射击冷却先埋好：tick 里 scores={kitpvp.earth_cd_a=..0} 要求分数已存在，否则整条静默失效
scoreboard players set @e[tag=kitpvp.earth_lowflyer_body] kitpvp.earth_cd_a 40
# ★ 骷髅带 NoAI：原版骷髅的索敌只看"最近玩家"，不认主人，没法排除召唤者；
#   所以关掉它的脑子，箭由 skill/earth/lowflyer_shoot 每 2 秒朝"不是召唤者"的人点名射一发（3 点、arrow 类型）
# 手动补上归属：队伍 + earth_owner，否则骷髅会朝召唤者放箭（它只看"最近玩家"，不认主人）
scoreboard players operation @e[tag=kitpvp.earth_lowflyer_body,limit=1] kitpvp.earth_owner = @e[tag=kitpvp.earth_lowflyer_carrier,limit=1] kitpvp.earth_owner
scoreboard players operation #lf_t kitpvp.game = @e[tag=kitpvp.earth_lowflyer_carrier,limit=1] kitpvp.earth_owner
execute if score #lf_t kitpvp.game matches 1 as @e[tag=kitpvp.earth_lowflyer_body] run team join earth_1 @s
execute if score #lf_t kitpvp.game matches 2 as @e[tag=kitpvp.earth_lowflyer_body] run team join earth_2 @s
execute if score #lf_t kitpvp.game matches 3 as @e[tag=kitpvp.earth_lowflyer_body] run team join earth_3 @s
execute if score #lf_t kitpvp.game matches 4 as @e[tag=kitpvp.earth_lowflyer_body] run team join earth_4 @s
execute if score #lf_t kitpvp.game matches 5 as @e[tag=kitpvp.earth_lowflyer_body] run team join earth_5 @s
execute if score #lf_t kitpvp.game matches 6 as @e[tag=kitpvp.earth_lowflyer_body] run team join earth_6 @s
