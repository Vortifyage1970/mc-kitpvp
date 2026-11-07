# 由 summon/earth_flyer 排程 1 刻后调用，别直接跑
# 旧幻翼虽然被 kill 了，但要播完死亡动画（约 20 刻）才真的从世界里消失，这期间它的 UUID 还占着，
# 同一个 UUID 再 summon 会被 addFreshEntity 静默丢掉 —— 所以这里每刻重试，最多 60 刻（3 秒），成功即收工
execute if entity @e[tag=kitpvp.fl_anchor,limit=1] unless entity @e[tag=kitpvp.earth_flyer_carrier,nbt=!{Health:0.0f}] at @e[tag=kitpvp.fl_anchor,limit=1] run summon minecraft:phantom ~ ~ ~ {UUID:[I;1900010,1,1,1],Tags:["kitpvp.earth_minion","kitpvp.earth_minion_new","kitpvp.earth_flyer","kitpvp.earth_flyer_carrier","kitpvp.fl_spawning"],Size:1,CustomName:'{"text":"飞行器","color":"dark_aqua"}',CustomNameVisible:1b,PersistenceRequired:1b,Silent:1b}
# 召唤成功（fl_spawning 只有刚召的这只才有）
execute if entity @e[tag=kitpvp.fl_spawning,limit=1] run kill @e[tag=kitpvp.fl_anchor]
execute if entity @e[tag=kitpvp.fl_spawning,limit=1] run tellraw @a {"text":"[A] 幻翼出来了","color":"green"}
# 抗性 V 让它打不死（被打烂就失去"吊车"的意义），虚弱 X 让它近战无伤害
execute if entity @e[tag=kitpvp.fl_spawning,limit=1] run effect give @e[tag=kitpvp.earth_flyer_carrier,limit=1,nbt=!{Health:0.0f}] minecraft:resistance infinite 4 true
execute if entity @e[tag=kitpvp.fl_spawning,limit=1] run effect give @e[tag=kitpvp.earth_flyer_carrier,limit=1,nbt=!{Health:0.0f}] minecraft:weakness infinite 9 true
execute if entity @e[tag=kitpvp.fl_spawning,limit=1] run scoreboard players set @e[tag=kitpvp.earth_flyer_carrier,nbt=!{Health:0.0f}] kitpvp.earth_cd_a 200
execute if entity @e[tag=kitpvp.fl_spawning,limit=1] run schedule function kitpvp:summon/earth_flyer_b 1t replace
# 还没成功就再等一刻；3 秒还没成功就放弃，别把 marker 留在场上
execute unless entity @e[tag=kitpvp.fl_spawning] if entity @e[tag=kitpvp.fl_anchor,limit=1] if score #fl_wait kitpvp.game matches 1.. run schedule function kitpvp:summon/earth_flyer_a 1t replace
execute if score #fl_wait kitpvp.game matches 1.. run scoreboard players remove #fl_wait kitpvp.game 1
execute if score #fl_wait kitpvp.game matches 0 if entity @e[tag=kitpvp.fl_anchor,limit=1] run tellraw @a {"text":"[A] 3 秒都没召出来，放弃","color":"red"}
execute if score #fl_wait kitpvp.game matches 0 run kill @e[tag=kitpvp.fl_anchor]
