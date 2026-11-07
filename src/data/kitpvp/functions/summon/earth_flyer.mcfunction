# 地球·69 飞行器：幻翼吊着骷髅弓箭手盘旋，每 10 秒俯冲 17 格；骷髅死则幻翼同死
# 分两帧召：同一帧召出的实体不在 UUID 索引里，Leash 会被静默丢弃
# 场上一对（UUID 写死给 Leash 用），所以先清掉上一对
kill @e[tag=kitpvp.earth_flyer_carrier]
kill @e[tag=kitpvp.earth_flyer_body]
scoreboard players add #fl_slot kitpvp.game 1
execute if score #fl_slot kitpvp.game matches 3.. run scoreboard players set #fl_slot kitpvp.game 1
execute if score #fl_slot kitpvp.game matches 1 run summon minecraft:phantom ~ ~2 ~ {UUID:[I;1900010,1,1,1],Tags:["kitpvp.earth_minion","kitpvp.earth_minion_new","kitpvp.earth_flyer","kitpvp.earth_flyer_carrier","kitpvp.fl_slot_a"],Size:1,CustomName:'{"text":"飞行器","color":"dark_aqua"}',CustomNameVisible:1b,PersistenceRequired:1b,Silent:1b}
execute if score #fl_slot kitpvp.game matches 2 run summon minecraft:phantom ~ ~2 ~ {UUID:[I;1900011,1,1,1],Tags:["kitpvp.earth_minion","kitpvp.earth_minion_new","kitpvp.earth_flyer","kitpvp.earth_flyer_carrier","kitpvp.fl_slot_b"],Size:1,CustomName:'{"text":"飞行器","color":"dark_aqua"}',CustomNameVisible:1b,PersistenceRequired:1b,Silent:1b}
# 抗性 V 让它打不死（被打烂就失去"吊车"的意义），虚弱 X 让它近战无伤害
execute if score #fl_slot kitpvp.game matches 1 as @e[tag=kitpvp.earth_flyer_carrier,tag=kitpvp.fl_slot_a] run effect give @s minecraft:resistance infinite 4 true
execute if score #fl_slot kitpvp.game matches 2 as @e[tag=kitpvp.earth_flyer_carrier,tag=kitpvp.fl_slot_b] run effect give @s minecraft:resistance infinite 4 true
execute if score #fl_slot kitpvp.game matches 1 as @e[tag=kitpvp.earth_flyer_carrier,tag=kitpvp.fl_slot_a] run effect give @s minecraft:weakness infinite 9 true
execute if score #fl_slot kitpvp.game matches 2 as @e[tag=kitpvp.earth_flyer_carrier,tag=kitpvp.fl_slot_b] run effect give @s minecraft:weakness infinite 9 true
execute if score #fl_slot kitpvp.game matches 1 as @e[tag=kitpvp.earth_flyer_carrier,tag=kitpvp.fl_slot_a] run scoreboard players set @s kitpvp.earth_cd_a 200
execute if score #fl_slot kitpvp.game matches 2 as @e[tag=kitpvp.earth_flyer_carrier,tag=kitpvp.fl_slot_b] run scoreboard players set @s kitpvp.earth_cd_a 200
schedule function kitpvp:summon/earth_flyer_b 1t replace
