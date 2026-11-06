# 地球·69 飞行器：幻翼吊着骷髅弓箭手盘旋，每 10 秒俯冲 25 格；骷髅死则幻翼同死
# 分两帧召：同一帧召出的实体不在 UUID 索引里，Leash 会被静默丢弃
# 场上一对（UUID 写死给 Leash 用），所以先清掉上一对
kill @e[tag=kitpvp.earth_flyer_carrier]
kill @e[tag=kitpvp.earth_flyer_body]
summon minecraft:phantom ~ ~2 ~ {UUID:[I;1900010,1,1,1],Tags:["kitpvp.earth_minion","kitpvp.earth_minion_new","kitpvp.earth_flyer","kitpvp.earth_flyer_carrier"],Size:1,CustomName:'{"text":"飞行器","color":"dark_aqua"}',CustomNameVisible:1b,PersistenceRequired:1b,Silent:1b}
# 抗性 V 让它打不死（被打烂就失去"吊车"的意义），虚弱 X 让它近战无伤害
effect give @e[tag=kitpvp.earth_flyer_carrier,limit=1,sort=nearest] minecraft:resistance infinite 4 true
effect give @e[tag=kitpvp.earth_flyer_carrier,limit=1,sort=nearest] minecraft:weakness infinite 9 true
scoreboard players set @e[tag=kitpvp.earth_flyer_carrier] kitpvp.earth_cd_a 200
# 宽限 10 刻：吊舱是下一帧才出生的，不加宽限母体第一刻就会判定"吊舱没了"而自杀
scoreboard players set @e[tag=kitpvp.earth_flyer_carrier] kitpvp.flyer_grace 10
schedule function kitpvp:summon/earth_flyer_b 1t replace
