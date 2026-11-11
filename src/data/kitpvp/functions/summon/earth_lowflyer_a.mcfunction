# 由 summon/earth_lowflyer 排程 1 刻后调用，别直接跑
# 旧蝙蝠虽然被 kill 了，但要播完死亡动画才从世界里消失，这期间它的 UUID 还占着，
# 同一个 UUID 再 summon 会被 addFreshEntity 静默丢掉 —— 所以每刻重试，最多 60 刻（3 秒），成功即收工
execute if entity @e[tag=kitpvp.lf_anchor,limit=1] unless entity @e[tag=kitpvp.earth_lowflyer_carrier,nbt=!{Health:0.0f}] at @e[tag=kitpvp.lf_anchor,limit=1] run summon minecraft:bat ~ ~ ~ {UUID:[I;1900011,1,1,1],Tags:["kitpvp.earth_minion","kitpvp.earth_minion_new","kitpvp.earth_lowflyer","kitpvp.earth_lowflyer_carrier","kitpvp.lf_spawning"],CustomName:'{"text":"低空飞行器","color":"dark_aqua"}',CustomNameVisible:1b,PersistenceRequired:1b,Silent:1b,NoAI:1b,NoGravity:1b}
execute if entity @e[tag=kitpvp.lf_spawning,limit=1] run kill @e[tag=kitpvp.lf_anchor]
# 抗性 V（amplifier 4）= 完全免疫伤害：蝙蝠只有 6 血，不套这层它撑不过一箭
# 虚弱 X 让它自己那一口咬不掉人（真正的输出来自下面的骷髅）
execute if entity @e[tag=kitpvp.lf_spawning,limit=1] run effect give @e[tag=kitpvp.earth_lowflyer_carrier,limit=1,nbt=!{Health:0.0f}] minecraft:resistance infinite 4 true
execute if entity @e[tag=kitpvp.lf_spawning,limit=1] run effect give @e[tag=kitpvp.earth_lowflyer_carrier,limit=1,nbt=!{Health:0.0f}] minecraft:weakness infinite 9 true
execute if entity @e[tag=kitpvp.lf_spawning,limit=1] run schedule function kitpvp:summon/earth_lowflyer_b 1t replace
# 还没成功就再等一刻；3 秒还没成功就放弃，别把 marker 留在场上
execute unless entity @e[tag=kitpvp.lf_spawning] if entity @e[tag=kitpvp.lf_anchor,limit=1] if score #lf_wait kitpvp.game matches 1.. run schedule function kitpvp:summon/earth_lowflyer_a 1t replace
execute if score #lf_wait kitpvp.game matches 1.. run scoreboard players remove #lf_wait kitpvp.game 1
execute if score #lf_wait kitpvp.game matches 0 if entity @e[tag=kitpvp.lf_anchor,limit=1] run tellraw @a {"text":"[低空飞行器] 3 秒都没召出来，放弃","color":"red"}
execute if score #lf_wait kitpvp.game matches 0 run kill @e[tag=kitpvp.lf_anchor]
