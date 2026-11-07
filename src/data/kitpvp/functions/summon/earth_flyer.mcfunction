# 地球·69 飞行器：幻翼吊着骷髅弓箭手盘旋，每 10 秒俯冲 17 格；骷髅死则幻翼同死
# 分两帧召：同一帧召出的实体不在 UUID 索引里，Leash 会被静默丢弃
# 场上一对（UUID 写死给 Leash 用）；已经有母体时什么都不做——不杀、不召、不搬（重复 summon 会被 UUID 查重静默拒绝）
execute unless entity @e[tag=kitpvp.earth_flyer_carrier] run scoreboard players set #fl_new kitpvp.game 1
execute if score #fl_new kitpvp.game matches 1 run kill @e[tag=kitpvp.earth_flyer_carrier]
execute if score #fl_new kitpvp.game matches 1 run kill @e[tag=kitpvp.earth_flyer_body]
execute if score #fl_new kitpvp.game matches 1 run summon minecraft:phantom ~ ~2 ~ {UUID:[I;1900010,1,1,1],Tags:["kitpvp.earth_minion","kitpvp.earth_minion_new","kitpvp.earth_flyer","kitpvp.earth_flyer_carrier"],Size:1,CustomName:'{"text":"飞行器","color":"dark_aqua"}',CustomNameVisible:1b,PersistenceRequired:1b,Silent:1b}
# 抗性 V 让它打不死（被打烂就失去"吊车"的意义），虚弱 X 让它近战无伤害
execute if score #fl_new kitpvp.game matches 1 run effect give @e[tag=kitpvp.earth_flyer_carrier,limit=1,sort=nearest] minecraft:resistance infinite 4 true
execute if score #fl_new kitpvp.game matches 1 run effect give @e[tag=kitpvp.earth_flyer_carrier,limit=1,sort=nearest] minecraft:weakness infinite 9 true
execute if score #fl_new kitpvp.game matches 1 run scoreboard players set @e[tag=kitpvp.earth_flyer_carrier] kitpvp.earth_cd_a 200
execute if score #fl_new kitpvp.game matches 1 run schedule function kitpvp:summon/earth_flyer_b 1t replace
execute if score #fl_new kitpvp.game matches 1 run scoreboard players set #fl_new kitpvp.game 0