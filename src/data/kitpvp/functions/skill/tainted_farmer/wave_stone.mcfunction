# @s = 领袖：每 12 秒召一只石锄农民
# **没有单类上限**，只受「总农民数（石锄+木锄+领袖）< 256」限制，防实体爆炸
scoreboard players set #tf_wave kitpvp.game 240
scoreboard players set #tf_stone kitpvp.game 0
execute store result score #tf_stone kitpvp.game if entity @e[tag=kitpvp.tf_stone]
# 第一只石锄诞生（此前一只都没有）时，把木锄波次对齐到"石锄后 6 秒"（#tf_wave2 从 120 开始倒数）
execute if score #tf_stone kitpvp.game matches 0 run scoreboard players set #tf_wave2 kitpvp.game 120
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
execute if score #tf_all kitpvp.game matches ..254 at @s run function kitpvp:summon/tainted_farmer_stone
execute if score #tf_all kitpvp.game matches ..254 run scoreboard players operation @e[tag=kitpvp.team_new] kitpvp.tf_owner = #tf_own kitpvp.game
execute if score #tf_all kitpvp.game matches ..254 run function kitpvp:util/team_join
