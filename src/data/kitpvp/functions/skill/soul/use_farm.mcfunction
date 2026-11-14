# 首行推进快照，漏写会每刻重复触发
scoreboard players operation @s kitpvp.soul_farm_last = @s kitpvp.soul_farm_used

# 队伍跟着主人走：他已经在炮台 / 阴兵 / 生灵 / 炸弹兵某套队里就沿用，否则才开一个农民槽
# （绝不无脑改成 farmer_N —— 那会把他原有的召唤物变成敌人，见 04 §十五）
function kitpvp:util/team_index
execute if score #steam kitpvp.game matches 0 run function kitpvp:skill/tainted_farmer/team_slot
function kitpvp:util/team_index

execute as @e[type=minecraft:zombie_villager,tag=kitpvp.soul_farm_token,limit=1] at @s run function kitpvp:summon/soul_farm_leader
execute unless entity @e[type=minecraft:zombie_villager,tag=kitpvp.soul_farm_token] at @s run function kitpvp:summon/soul_farm_leader
execute at @s run kill @e[type=minecraft:zombie_villager,tag=kitpvp.soul_farm_token,distance=..16]

scoreboard players operation @e[tag=kitpvp.team_new] kitpvp.tf_owner = #steam kitpvp.game
function kitpvp:util/team_join

# 兵源节奏与里农夫一致：两条 12 秒的波次（错开 6 秒）
scoreboard players set #tf_wave kitpvp.game 240
scoreboard players set #tf_wave2 kitpvp.game 120

tellraw @a [{"text":"❖ ","color":"gold","bold":true},{"text":"农夫魂石·起义","color":"dark_green","bold":true},{"text":" ❖","color":"gold","bold":true}]
execute as @a at @s run playsound minecraft:entity.evoker.prepare_summon master @s ~ ~ ~ 0.8 0.9
title @s actionbar {"text":"魂石·起义：起义领袖已就位","color":"green"}
