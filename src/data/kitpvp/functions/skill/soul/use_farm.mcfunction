# 首行推进快照，漏写会每刻重复触发
scoreboard players operation @s kitpvp.soul_farm_last = @s kitpvp.soul_farm_used

# 魂石可能发到任何职业手里，所以队槽也要在这里分配一次（清空之后必须能重新分配，见 04 §15.1）
function kitpvp:skill/tainted_farmer/team_slot
scoreboard players operation #tf_own kitpvp.game = @s kitpvp.tfid

execute as @e[type=minecraft:zombie_villager,tag=kitpvp.soul_farm_token,limit=1] at @s run function kitpvp:summon/soul_farm_leader
execute unless entity @e[type=minecraft:zombie_villager,tag=kitpvp.soul_farm_token] at @s run function kitpvp:summon/soul_farm_leader
execute at @s run kill @e[type=minecraft:zombie_villager,tag=kitpvp.soul_farm_token,distance=..16]

scoreboard players operation @e[tag=kitpvp.tf_new,type=minecraft:zombie] kitpvp.tf_owner = #tf_own kitpvp.game
execute as @e[tag=kitpvp.tf_new,type=minecraft:zombie] run function kitpvp:skill/tainted_farmer/join_own

# 兵源节奏与里农夫一致：两条 12 秒的波次（错开 6 秒）
scoreboard players set #tf_wave kitpvp.game 240
scoreboard players set #tf_wave2 kitpvp.game 120

tellraw @a [{"text":"❖ ","color":"gold","bold":true},{"text":"农夫魂石·起义","color":"dark_green","bold":true},{"text":" ❖","color":"gold","bold":true}]
execute as @a at @s run playsound minecraft:entity.evoker.prepare_summon master @s ~ ~ ~ 0.8 0.9
title @s actionbar {"text":"魂石·起义：起义领袖已就位","color":"green"}
