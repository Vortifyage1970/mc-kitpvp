# @s = 随机一只石锄农民：每 12 秒（与领袖错开 6 秒）召一只木锄农民
# **没有单类上限**，只受「总农民数（石锄+木锄+领袖）< 256」限制，防实体爆炸
scoreboard players set #tf_wave2 kitpvp.game 240
scoreboard players set #tf_wood kitpvp.game 0
execute store result score #tf_wood kitpvp.game if entity @e[tag=kitpvp.tf_wood]
# 总农民数 = 石锄 + 木锄 + 领袖
scoreboard players set #tf_all kitpvp.game 0
execute store result score #tf_all kitpvp.game if entity @e[tag=kitpvp.tf_stone]
execute store result score #tf_tmp kitpvp.game if entity @e[tag=kitpvp.tf_wood]
scoreboard players operation #tf_all kitpvp.game += #tf_tmp kitpvp.game
execute store result score #tf_tmp kitpvp.game if entity @e[tag=kitpvp.tf_leader]
scoreboard players operation #tf_all kitpvp.game += #tf_tmp kitpvp.game
scoreboard players set #tf_own kitpvp.game 0
execute if score #tf_all kitpvp.game matches ..254 store result score #tf_own kitpvp.game run scoreboard players get @s kitpvp.tf_owner
execute if score #tf_all kitpvp.game matches ..254 run scoreboard players operation #steam kitpvp.game = #tf_own kitpvp.game
execute if score #tf_all kitpvp.game matches ..254 at @s run function kitpvp:summon/tainted_farmer_wood
execute if score #tf_all kitpvp.game matches ..254 run scoreboard players operation @e[tag=kitpvp.team_new] kitpvp.tf_owner = #tf_own kitpvp.game
execute if score #tf_all kitpvp.game matches ..254 run function kitpvp:util/team_join
