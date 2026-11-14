# 弓：只有背包里的普通箭真的少了才算"射出一箭"（拉弓取消不会扣）
# clear 用 0 个只统计不清
execute store result score #chaos_arrows kitpvp.game run clear @s minecraft:arrow 0
execute if score #chaos_arrows kitpvp.game < @s kitpvp.chaos_arrows run function kitpvp:kit/chaos_arrow_spent
scoreboard players operation @s kitpvp.chaos_arrows = #chaos_arrows kitpvp.game
