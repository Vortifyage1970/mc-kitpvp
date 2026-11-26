# 农民队的槽位（farmer_1..6）：分配 tfid（若为 0）并把主人 join 回自己的队。
# ⚠ 开局 game/start_impl 会把 tfid 清零（队槽每局重建），所以选职与每次召唤都要跑一次
execute if score @s kitpvp.tfid matches 0 run scoreboard players add #tfid kitpvp.game 1
execute if score @s kitpvp.tfid matches 0 if score #tfid kitpvp.game matches 7.. run scoreboard players set #tfid kitpvp.game 1
execute if score @s kitpvp.tfid matches 0 run scoreboard players operation @s kitpvp.tfid = #tfid kitpvp.game

execute if score @s kitpvp.tfid matches 1 run team join farmer_1 @s
execute if score @s kitpvp.tfid matches 2 run team join farmer_2 @s
execute if score @s kitpvp.tfid matches 3 run team join farmer_3 @s
execute if score @s kitpvp.tfid matches 4 run team join farmer_4 @s
execute if score @s kitpvp.tfid matches 5 run team join farmer_5 @s
execute if score @s kitpvp.tfid matches 6 run team join farmer_6 @s
