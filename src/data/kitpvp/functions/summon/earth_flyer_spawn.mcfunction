# 地球·69 飞行器：幻翼吊着骷髅弓箭手盘旋，每 10 秒俯冲 17 格；骷髅死则幻翼同死
summon minecraft:phantom ~ ~2 ~ {UUID:[I;1900010,1,1,1],Tags:["kitpvp.earth_minion","kitpvp.earth_minion_new","kitpvp.earth_flyer","kitpvp.earth_flyer_carrier"],Size:1,CustomName:'{"text":"飞行器","color":"dark_aqua"}',CustomNameVisible:1b,PersistenceRequired:1b,Silent:1b}
# 抗性 V 让它打不死（被打烂就失去"吊车"的意义），虚弱 X 让它近战无伤害
effect give @e[tag=kitpvp.earth_flyer_carrier,limit=1,sort=nearest] minecraft:resistance infinite 4 true
effect give @e[tag=kitpvp.earth_flyer_carrier,limit=1,sort=nearest] minecraft:weakness infinite 9 true
scoreboard players set @e[tag=kitpvp.earth_flyer_carrier] kitpvp.earth_cd_a 200
scoreboard players set @e[tag=kitpvp.earth_flyer_carrier] kitpvp.flyer_grace 10
schedule function kitpvp:summon/earth_flyer_b 1t replace
# 兜底：写了死 UUID，万一这一刻还没释放（addFreshEntity 会静默失败），再来一帧，最多 3 次 execute if entity @e[tag=kitpvp.earth_flyer_carrier] run scoreboard players set #fl_retry kitpvp.game 0 execute unless entity @e[tag=kitpvp.earth_flyer_carrier] run scoreboard players add #fl_retry kitpvp.game 1 execute unless entity @e[tag=kitpvp.earth_flyer_carrier] if score #fl_retry kitpvp.game matches ..3 run schedule function kitpvp:summon/earth_flyer_spawn 1t replace execute unless entity @e[tag=kitpvp.earth_flyer_carrier] if score #fl_retry kitpvp.game matches 4.. run tellraw @a [{"text":"[飞行器] 召唤失败：UUID 仍未释放","color":"red"}]
