# 地球·69 飞行器：幻翼吊着骷髅弓箭手盘旋，每 5 秒俯冲 50 格；骷髅死则幻翼同死
# 分两帧召：同一帧召出的实体不在 UUID 索引里，Leash 会被静默丢弃
# 场上一对（UUID 写死给 Leash 用），所以先清掉上一对
kill @e[tag=kitpvp.earth_flyer_carrier]
kill @e[tag=kitpvp.earth_flyer_body]
summon minecraft:phantom ~ ~2 ~ {UUID:[I;1900010,1,1,1],Tags:["kitpvp.earth_minion","kitpvp.earth_minion_new","kitpvp.earth_flyer","kitpvp.earth_flyer_carrier","kitpvp.fl_spawning"],Size:1,CustomName:'{"text":"飞行器","color":"dark_aqua"}',CustomNameVisible:1b,PersistenceRequired:1b,Silent:1b}
# 抗性 V 让它打不死（被打烂就失去"吊车"的意义），虚弱 X 让它近战无伤害
# 认准刚召的那只（fl_spawning 是它独有的），别用 sort=nearest —— 被 kill 的旧幻翼还没消失时往往更近，效果会加到快死的旧身上
effect give @e[tag=kitpvp.fl_spawning,limit=1] minecraft:resistance infinite 4 true
effect give @e[tag=kitpvp.fl_spawning,limit=1] minecraft:weakness infinite 9 true
scoreboard players set @e[tag=kitpvp.earth_flyer_carrier] kitpvp.earth_cd_a 100
schedule function kitpvp:summon/earth_flyer_b 1t replace
