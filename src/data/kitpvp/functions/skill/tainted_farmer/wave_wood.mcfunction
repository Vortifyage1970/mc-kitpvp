# @s = 随机一只石锄农民：每 12 秒（与领袖错开 6 秒）召一只木锄农民（上限 12 只）
scoreboard players set #tf_wave2 kitpvp.game 240
scoreboard players set #tf_wood kitpvp.game 0
execute store result score #tf_wood kitpvp.game if entity @e[tag=kitpvp.tf_wood]
scoreboard players set #tf_own kitpvp.game 0
execute if score #tf_wood kitpvp.game matches ..11 store result score #tf_own kitpvp.game run scoreboard players get @s kitpvp.tf_owner
execute if score #tf_wood kitpvp.game matches ..11 at @s run function kitpvp:summon/tainted_farmer_wood
execute if score #tf_wood kitpvp.game matches ..11 run scoreboard players operation @e[tag=kitpvp.tf_new,type=minecraft:zombie] kitpvp.tf_owner = #tf_own kitpvp.game
execute if score #tf_wood kitpvp.game matches ..11 as @e[tag=kitpvp.tf_new,type=minecraft:zombie] run function kitpvp:skill/tainted_farmer/join_own
