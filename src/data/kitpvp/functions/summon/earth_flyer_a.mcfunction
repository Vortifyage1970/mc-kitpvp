# 由 summon/earth_flyer 排程 1 刻后调用，别直接跑：这时旧的一对已经真的没了，写死的 UUID 才空得出来
# 出生就放在头顶 22 格（marker 已经带好高度）：俯冲是"朝目标飞、离 3 格收手"，贴着召唤者出生的话第一次俯冲只有 4-5 格可冲
execute if entity @e[tag=kitpvp.fl_anchor,limit=1] at @e[tag=kitpvp.fl_anchor,limit=1] run summon minecraft:phantom ~ ~ ~ {UUID:[I;1900010,1,1,1],Tags:["kitpvp.earth_minion","kitpvp.earth_minion_new","kitpvp.earth_flyer","kitpvp.earth_flyer_carrier","kitpvp.fl_spawning"],Size:1,CustomName:'{"text":"飞行器","color":"dark_aqua"}',CustomNameVisible:1b,PersistenceRequired:1b,Silent:1b}
kill @e[tag=kitpvp.fl_anchor]
# 抗性 V 让它打不死（被打烂就失去"吊车"的意义），虚弱 X 让它近战无伤害
# 认准刚召的那只（fl_spawning 是它独有的），别用 sort=nearest —— 上一刻被 kill 的旧幻翼可能还在
effect give @e[tag=kitpvp.fl_spawning,limit=1] minecraft:resistance infinite 4 true
effect give @e[tag=kitpvp.fl_spawning,limit=1] minecraft:weakness infinite 9 true
scoreboard players set @e[tag=kitpvp.earth_flyer_carrier] kitpvp.earth_cd_a 200
schedule function kitpvp:summon/earth_flyer_b 1t replace
