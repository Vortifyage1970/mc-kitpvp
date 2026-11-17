# 由 summon/earth_lowflyer 排程 1 刻后调用，别直接跑
# 旧蝙蝠虽然被 kill 了，但要播完死亡动画才从世界里消失，这期间它的 UUID 还占着，
# 同一个 UUID 再 summon 会被 addFreshEntity 静默丢掉 —— 所以每刻重试，最多 60 刻（3 秒），成功即收工
# 蝙蝠是正常生物：有 AI、吃重力（原版蝙蝠本来就会飞），不再套 NoGravity
execute if entity @e[tag=kitpvp.lf_anchor,limit=1] unless entity @e[tag=kitpvp.earth_lowflyer_carrier,nbt=!{Health:0.0f}] at @e[tag=kitpvp.lf_anchor,limit=1] run summon minecraft:bat ~ ~ ~ {UUID:[I;1900011,1,1,1],Tags:["kitpvp.earth_minion","kitpvp.earth_minion_new","kitpvp.earth_lowflyer","kitpvp.earth_lowflyer_carrier","kitpvp.lf_spawning"],CustomName:'{"text":"低空飞行器","color":"dark_aqua"}',CustomNameVisible:1b,PersistenceRequired:1b,Silent:1b}
execute if entity @e[tag=kitpvp.lf_spawning,limit=1] run kill @e[tag=kitpvp.lf_anchor]
# 抗性 V（amplifier 4）= 完全免疫伤害：蝙蝠只有 6 血，不套这层它撑不过一箭
# 虚弱 X 让它自己那一口咬不掉人（真正的输出来自下面的骷髅）
execute if entity @e[tag=kitpvp.lf_spawning,limit=1] run effect give @e[tag=kitpvp.lf_spawning,limit=1] minecraft:resistance infinite 4 true
execute if entity @e[tag=kitpvp.lf_spawning,limit=1] run effect give @e[tag=kitpvp.lf_spawning,limit=1] minecraft:weakness infinite 9 true
# ★ 认归属：靠"召唤者 tag"而不是靠计分。分数没建 / 玩家是中途加入 / 没 /reload 时，
#   `if score ... matches 1..` 会静默不成立，整条队伍链就白跑（上一版就是这么坏的）
# 召唤者站在哪个队，就把蝙蝠并进哪个队（6 行试完即止；召唤者没队时全都不会命中）
execute as @a[tag=kitpvp.lf_owner_tmp,team=earth_1] run team join earth_1 @e[tag=kitpvp.lf_spawning]
execute as @a[tag=kitpvp.lf_owner_tmp,team=earth_2] run team join earth_2 @e[tag=kitpvp.lf_spawning]
execute as @a[tag=kitpvp.lf_owner_tmp,team=earth_3] run team join earth_3 @e[tag=kitpvp.lf_spawning]
execute as @a[tag=kitpvp.lf_owner_tmp,team=earth_4] run team join earth_4 @e[tag=kitpvp.lf_spawning]
execute as @a[tag=kitpvp.lf_owner_tmp,team=earth_5] run team join earth_5 @e[tag=kitpvp.lf_spawning]
execute as @a[tag=kitpvp.lf_owner_tmp,team=earth_6] run team join earth_6 @e[tag=kitpvp.lf_spawning]
# 归属分数顺手写上（草丛 / 电磁炮那类读分数；写不上也不影响"不打召唤者"，那只靠队伍）
execute as @a[tag=kitpvp.lf_owner_tmp] run scoreboard players operation @e[tag=kitpvp.lf_spawning] kitpvp.earth_owner = @s kitpvp.etid
# 摘掉"新召唤"标签：否则下次别人在旁边召唤时，link 会把这只已经认过主的蝙蝠重新算到自己名下
tag @e[tag=kitpvp.earth_lowflyer_carrier] remove kitpvp.earth_minion_new
# 吊舱也可能撞 UUID（上一具骷髅还在播死亡动画），给 _b 留 20 刻重试预算
execute if entity @e[tag=kitpvp.lf_spawning,limit=1] run scoreboard players set #lf_body_wait kitpvp.game 20
execute if entity @e[tag=kitpvp.lf_spawning,limit=1] run schedule function kitpvp:summon/earth_lowflyer_b 1t replace
# 召成功了就把召唤者 tag 收掉（没成功就留着，下一帧重试还要用）
execute if entity @e[tag=kitpvp.lf_spawning,limit=1] run tag @a remove kitpvp.lf_owner_tmp
# 还没成功就再等一刻；3 秒还没成功就放弃，别把 marker 留在场上
execute unless entity @e[tag=kitpvp.lf_spawning] if entity @e[tag=kitpvp.lf_anchor,limit=1] if score #lf_wait kitpvp.game matches 1.. run schedule function kitpvp:summon/earth_lowflyer_a 1t replace
execute if score #lf_wait kitpvp.game matches 1.. run scoreboard players remove #lf_wait kitpvp.game 1
execute if score #lf_wait kitpvp.game matches 0 if entity @e[tag=kitpvp.lf_anchor,limit=1] run tellraw @a {"text":"[低空飞行器] 3 秒都没召出来，放弃","color":"red"}
execute if score #lf_wait kitpvp.game matches 0 run kill @e[tag=kitpvp.lf_anchor]
execute if score #lf_wait kitpvp.game matches 0 run tag @a remove kitpvp.lf_owner_tmp
