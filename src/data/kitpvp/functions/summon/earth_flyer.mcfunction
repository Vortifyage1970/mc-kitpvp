# 地球·69 飞行器：幻翼吊着骷髅弓箭手盘旋，每 10 秒俯冲 17 格；骷髅死则幻翼同死
# 分两帧召：同一帧召出的实体不在 UUID 索引里，Leash 会被静默丢弃
# 场上一对（UUID 写死给 Leash 用）；召唤 = 换新的一对：先清旧的，再用"上一只没用过的那套 UUID"召
# 两套 UUID 交替使用（A/B）：刚被杀掉的旧对占着的那套本刻还在，另一套早在上一轮就释放了，所以 summon 不会撞 UUID
# 每次召唤都换一只新的：场上有旧的也照样清掉重召（幻翼本体除了"被清掉"，行为一个字没动）
scoreboard players add #fl_slot kitpvp.game 1
execute if score #fl_slot kitpvp.game matches 3.. run scoreboard players set #fl_slot kitpvp.game 1
kill @e[tag=kitpvp.earth_flyer_carrier]
kill @e[tag=kitpvp.earth_flyer_body]
execute if score #fl_slot kitpvp.game matches 1 run summon minecraft:phantom ~ ~2 ~ {UUID:[I;1900010,1,1,1],Tags:["kitpvp.earth_minion","kitpvp.earth_minion_new","kitpvp.earth_flyer","kitpvp.earth_flyer_carrier","kitpvp.fl_slot_a"],Size:1,CustomName:'{"text":"飞行器","color":"dark_aqua"}',CustomNameVisible:1b,PersistenceRequired:1b,Silent:1b}
execute if score #fl_slot kitpvp.game matches 2 run summon minecraft:phantom ~ ~2 ~ {UUID:[I;1900011,1,1,1],Tags:["kitpvp.earth_minion","kitpvp.earth_minion_new","kitpvp.earth_flyer","kitpvp.earth_flyer_carrier","kitpvp.fl_slot_b"],Size:1,CustomName:'{"text":"飞行器","color":"dark_aqua"}',CustomNameVisible:1b,PersistenceRequired:1b,Silent:1b}
# 虚弱 X 让它近战无伤害；不给抗性提升，白天照样会被晒（要能扛就调血量）
effect give @e[tag=kitpvp.earth_flyer_carrier,limit=1,sort=nearest] minecraft:weakness infinite 9 true
scoreboard players set @e[tag=kitpvp.earth_flyer_carrier] kitpvp.earth_cd_a 200
execute as @e[tag=kitpvp.earth_flyer_carrier] run scoreboard players set @s kitpvp.flyer_grace 10
schedule function kitpvp:summon/earth_flyer_b 1t replace
