# 地球·69 飞行器·第一帧：召唤幻翼（由 summon/earth_flyer 清场后 1 刻调用）
# UUID 是写死的（Leash 要用它），而 ServerLevel.addFreshEntity 对已存在的 UUID 会静默返回 false，
# 所以必须先 kill、隔一帧再 summon；万一那一帧还没释放，本文件会自己重试（最多 3 次）。
tellraw @a [{"text":"[飞行器] 正在召幻翼","color":"dark_gray"}]
summon minecraft:phantom ~ ~2 ~ {UUID:[I;1900010,1,1,1],Tags:["kitpvp.earth_minion","kitpvp.earth_minion_new","kitpvp.earth_flyer","kitpvp.earth_flyer_carrier"],Size:1,CustomName:'{"text":"飞行器","color":"dark_aqua"}',CustomNameVisible:1b,PersistenceRequired:1b,Silent:1b}
effect give @e[tag=kitpvp.earth_flyer_carrier,limit=1,sort=nearest] minecraft:resistance infinite 4 true
effect give @e[tag=kitpvp.earth_flyer_carrier,limit=1,sort=nearest] minecraft:weakness infinite 9 true
scoreboard players set @e[tag=kitpvp.earth_flyer_carrier] kitpvp.earth_cd_a 200
scoreboard players set @e[tag=kitpvp.earth_flyer_carrier] kitpvp.flyer_grace 10
# 成功：清重试计数，1 刻后召吊舱（吊舱的 Leash 要用幻翼的 UUID，必须另起一帧）
execute if entity @e[tag=kitpvp.earth_flyer_carrier] run scoreboard players set #fl_retry kitpvp.game 0
execute if entity @e[tag=kitpvp.earth_flyer_carrier] run tellraw @a [{"text":"[飞行器] 幻翼已生成","color":"green"}]
execute if entity @e[tag=kitpvp.earth_flyer_carrier] run schedule function kitpvp:summon/earth_flyer_b 1t replace
# 失败：可能是 UUID 还没释放，再等一帧重试（最多 3 次，避免死循环）
execute unless entity @e[tag=kitpvp.earth_flyer_carrier] run scoreboard players add #fl_retry kitpvp.game 1
execute unless entity @e[tag=kitpvp.earth_flyer_carrier] if score #fl_retry kitpvp.game matches ..3 run tellraw @a [{"text":"[飞行器] 幻翼没出来，下一帧重试","color":"red"}]
execute unless entity @e[tag=kitpvp.earth_flyer_carrier] if score #fl_retry kitpvp.game matches ..3 run schedule function kitpvp:summon/earth_flyer_spawn 1t replace
execute unless entity @e[tag=kitpvp.earth_flyer_carrier] if score #fl_retry kitpvp.game matches 4.. run tellraw @a [{"text":"[飞行器] 召唤失败：UUID 一直没释放","color":"red"}]
