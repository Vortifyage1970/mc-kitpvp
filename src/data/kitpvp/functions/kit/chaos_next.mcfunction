# 武器用尽：随机发下一把（池子大小由 tools/gen_chaos.py 写出）
# 发之前先把带 ChaosBlade 标签的武器全清掉（任何格子），杜绝叠刀
function kitpvp:kit/chaos_wipe
scoreboard players set @s kitpvp.rng 0
execute if predicate kitpvp:random/1in2 run scoreboard players add @s kitpvp.rng 1
execute if predicate kitpvp:random/1in2 run scoreboard players add @s kitpvp.rng 2
execute if predicate kitpvp:random/1in2 run scoreboard players add @s kitpvp.rng 4
execute if predicate kitpvp:random/1in2 run scoreboard players add @s kitpvp.rng 8
execute if predicate kitpvp:random/1in2 run scoreboard players add @s kitpvp.rng 16
execute if predicate kitpvp:random/1in2 run scoreboard players add @s kitpvp.rng 32
execute if predicate kitpvp:random/1in2 run scoreboard players add @s kitpvp.rng 64
scoreboard players set #chaos_pool kitpvp.game 19
scoreboard players operation @s kitpvp.rng %= #chaos_pool kitpvp.game
execute if score @s kitpvp.rng matches 0 run function kitpvp:kit/chaos_give_1
execute if score @s kitpvp.rng matches 1 run function kitpvp:kit/chaos_give_2
execute if score @s kitpvp.rng matches 2 run function kitpvp:kit/chaos_give_3
execute if score @s kitpvp.rng matches 3 run function kitpvp:kit/chaos_give_4
execute if score @s kitpvp.rng matches 4 run function kitpvp:kit/chaos_give_5
execute if score @s kitpvp.rng matches 5 run function kitpvp:kit/chaos_give_6
execute if score @s kitpvp.rng matches 6 run function kitpvp:kit/chaos_give_7
execute if score @s kitpvp.rng matches 7 run function kitpvp:kit/chaos_give_8
execute if score @s kitpvp.rng matches 8 run function kitpvp:kit/chaos_give_9
execute if score @s kitpvp.rng matches 9 run function kitpvp:kit/chaos_give_10
execute if score @s kitpvp.rng matches 10 run function kitpvp:kit/chaos_give_11
execute if score @s kitpvp.rng matches 11 run function kitpvp:kit/chaos_give_12
execute if score @s kitpvp.rng matches 12 run function kitpvp:kit/chaos_give_13
execute if score @s kitpvp.rng matches 13 run function kitpvp:kit/chaos_give_14
execute if score @s kitpvp.rng matches 14 run function kitpvp:kit/chaos_give_15
execute if score @s kitpvp.rng matches 15 run function kitpvp:kit/chaos_give_16
execute if score @s kitpvp.rng matches 16 run function kitpvp:kit/chaos_give_17
execute if score @s kitpvp.rng matches 17 run function kitpvp:kit/chaos_give_18
execute if score @s kitpvp.rng matches 18 run function kitpvp:kit/chaos_give_19
