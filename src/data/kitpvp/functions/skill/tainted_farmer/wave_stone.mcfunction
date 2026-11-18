# @s = 领袖：每 12 秒召一只石锄农民（上限 8 只，跟着领袖记下的队编号走）
scoreboard players set #tf_wave kitpvp.game 240
scoreboard players set #tf_stone kitpvp.game 0
execute store result score #tf_stone kitpvp.game if entity @e[tag=kitpvp.tf_stone]
# 第一只石锄诞生（此前一只都没有）时，把木锄波次对齐到"石锄后 6 秒"（#tf_wave2 从 120 开始倒数）
execute if score #tf_stone kitpvp.game matches 0 run scoreboard players set #tf_wave2 kitpvp.game 120
scoreboard players set #tf_own kitpvp.game 0
execute if score #tf_stone kitpvp.game matches ..7 store result score #tf_own kitpvp.game run scoreboard players get @s kitpvp.tf_owner
execute if score #tf_stone kitpvp.game matches ..7 run scoreboard players operation #steam kitpvp.game = #tf_own kitpvp.game
execute if score #tf_stone kitpvp.game matches ..7 at @s run function kitpvp:summon/tainted_farmer_stone
execute if score #tf_stone kitpvp.game matches ..7 run scoreboard players operation @e[tag=kitpvp.team_new] kitpvp.tf_owner = #tf_own kitpvp.game
execute if score #tf_stone kitpvp.game matches ..7 run function kitpvp:util/team_join
