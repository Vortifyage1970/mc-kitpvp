# @s = 领袖：每 12 秒召一只石锄农民（上限 8 只，跟着领袖的队走）
scoreboard players set #tf_wave kitpvp.game 240
scoreboard players set #tf_stone kitpvp.game 0
execute store result score #tf_stone kitpvp.game if entity @e[tag=kitpvp.tf_stone]
scoreboard players set #tf_own kitpvp.game 0
execute if score #tf_stone kitpvp.game matches ..7 store result score #tf_own kitpvp.game run scoreboard players get @s kitpvp.tf_owner
execute if score #tf_stone kitpvp.game matches ..7 at @s run function kitpvp:summon/tainted_farmer_stone
execute if score #tf_stone kitpvp.game matches ..7 run scoreboard players operation @e[tag=kitpvp.tf_new,type=minecraft:zombie] kitpvp.tf_owner = #tf_own kitpvp.game
execute if score #tf_stone kitpvp.game matches ..7 as @e[tag=kitpvp.tf_new,type=minecraft:zombie] run function kitpvp:skill/tainted_farmer/join_own
