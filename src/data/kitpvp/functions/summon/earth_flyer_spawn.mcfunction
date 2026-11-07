# 地球·69 飞行器·第二帧：召唤幻翼（由 tick.mcfunction 按 #fl_spawn 派发）
# 写了死 UUID（Leash 要用），addFreshEntity 遇到已存在的 UUID 会静默失败 ⇒ 失败就下一帧重试，最多 3 次
summon minecraft:phantom ~ ~2 ~ {UUID:[I;1900010,1,1,1],Tags:["kitpvp.earth_minion","kitpvp.earth_minion_new","kitpvp.earth_flyer","kitpvp.earth_flyer_carrier"],Size:1,CustomName:'{"text":"飞行器","color":"dark_aqua"}',CustomNameVisible:1b,PersistenceRequired:1b,Silent:1b}
effect give @e[tag=kitpvp.earth_flyer_carrier,limit=1,sort=nearest] minecraft:resistance infinite 4 true
effect give @e[tag=kitpvp.earth_flyer_carrier,limit=1,sort=nearest] minecraft:weakness infinite 9 true
scoreboard players set @e[tag=kitpvp.earth_flyer_carrier] kitpvp.earth_cd_a 200
scoreboard players set @e[tag=kitpvp.earth_flyer_carrier] kitpvp.flyer_grace 10
execute if entity @e[tag=kitpvp.earth_flyer_carrier] run tellraw @a [{"text":"[飞行器] 幻翼已生成","color":"green"}]
execute if entity @e[tag=kitpvp.earth_flyer_carrier] run scoreboard players set #fl_retry kitpvp.game 0
execute if entity @e[tag=kitpvp.earth_flyer_carrier] run scoreboard players set #fl_body kitpvp.game 1
execute unless entity @e[tag=kitpvp.earth_flyer_carrier] run scoreboard players add #fl_retry kitpvp.game 1
execute unless entity @e[tag=kitpvp.earth_flyer_carrier] if score #fl_retry kitpvp.game matches ..3 run tellraw @a [{"text":"[飞行器] 幻翼没出来，下一帧重试","color":"red"}]
execute unless entity @e[tag=kitpvp.earth_flyer_carrier] if score #fl_retry kitpvp.game matches ..3 run scoreboard players set #fl_spawn kitpvp.game 1
execute unless entity @e[tag=kitpvp.earth_flyer_carrier] if score #fl_retry kitpvp.game matches 4.. run tellraw @a [{"text":"[飞行器] 召唤失败：UUID 一直没释放","color":"red"}]
