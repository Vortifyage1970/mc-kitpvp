# 抽卡：先掷大奖（13 位 = 0..8191），没出货再掷四星（10%），其余三星蓄力
scoreboard players set #li_407 kitpvp.game 407
scoreboard players set #li_8192 kitpvp.game 8192
scoreboard players set #li_102 kitpvp.game 102
scoreboard players set #li_t kitpvp.game 49
execute if score @s kitpvp.li_pity matches 70.. run scoreboard players operation #li_t kitpvp.game = @s kitpvp.li_pity
execute if score @s kitpvp.li_pity matches 70.. run scoreboard players remove #li_t kitpvp.game 70
execute if score @s kitpvp.li_pity matches 70.. run scoreboard players operation #li_t kitpvp.game *= #li_407 kitpvp.game
execute if score @s kitpvp.li_pity matches 70.. run scoreboard players add #li_t kitpvp.game 49
execute if score @s kitpvp.li_pity matches 90.. run scoreboard players set #li_t kitpvp.game 8192
scoreboard players set #li_r kitpvp.game 0
execute store success score #li_b kitpvp.game if predicate kitpvp:random/1in2
execute if score #li_b kitpvp.game matches 1 run scoreboard players add #li_r kitpvp.game 1
execute store success score #li_b kitpvp.game if predicate kitpvp:random/1in2
execute if score #li_b kitpvp.game matches 1 run scoreboard players add #li_r kitpvp.game 2
execute store success score #li_b kitpvp.game if predicate kitpvp:random/1in2
execute if score #li_b kitpvp.game matches 1 run scoreboard players add #li_r kitpvp.game 4
execute store success score #li_b kitpvp.game if predicate kitpvp:random/1in2
execute if score #li_b kitpvp.game matches 1 run scoreboard players add #li_r kitpvp.game 8
execute store success score #li_b kitpvp.game if predicate kitpvp:random/1in2
execute if score #li_b kitpvp.game matches 1 run scoreboard players add #li_r kitpvp.game 16
execute store success score #li_b kitpvp.game if predicate kitpvp:random/1in2
execute if score #li_b kitpvp.game matches 1 run scoreboard players add #li_r kitpvp.game 32
execute store success score #li_b kitpvp.game if predicate kitpvp:random/1in2
execute if score #li_b kitpvp.game matches 1 run scoreboard players add #li_r kitpvp.game 64
execute store success score #li_b kitpvp.game if predicate kitpvp:random/1in2
execute if score #li_b kitpvp.game matches 1 run scoreboard players add #li_r kitpvp.game 128
execute store success score #li_b kitpvp.game if predicate kitpvp:random/1in2
execute if score #li_b kitpvp.game matches 1 run scoreboard players add #li_r kitpvp.game 256
execute store success score #li_b kitpvp.game if predicate kitpvp:random/1in2
execute if score #li_b kitpvp.game matches 1 run scoreboard players add #li_r kitpvp.game 512
execute store success score #li_b kitpvp.game if predicate kitpvp:random/1in2
execute if score #li_b kitpvp.game matches 1 run scoreboard players add #li_r kitpvp.game 1024
execute store success score #li_b kitpvp.game if predicate kitpvp:random/1in2
execute if score #li_b kitpvp.game matches 1 run scoreboard players add #li_r kitpvp.game 2048
execute store success score #li_b kitpvp.game if predicate kitpvp:random/1in2
execute if score #li_b kitpvp.game matches 1 run scoreboard players add #li_r kitpvp.game 4096
scoreboard players set #li_r4 kitpvp.game 0
execute store success score #li_b kitpvp.game if predicate kitpvp:random/1in2
execute if score #li_b kitpvp.game matches 1 run scoreboard players add #li_r4 kitpvp.game 1
execute store success score #li_b kitpvp.game if predicate kitpvp:random/1in2
execute if score #li_b kitpvp.game matches 1 run scoreboard players add #li_r4 kitpvp.game 2
execute store success score #li_b kitpvp.game if predicate kitpvp:random/1in2
execute if score #li_b kitpvp.game matches 1 run scoreboard players add #li_r4 kitpvp.game 4
execute store success score #li_b kitpvp.game if predicate kitpvp:random/1in2
execute if score #li_b kitpvp.game matches 1 run scoreboard players add #li_r4 kitpvp.game 8
execute store success score #li_b kitpvp.game if predicate kitpvp:random/1in2
execute if score #li_b kitpvp.game matches 1 run scoreboard players add #li_r4 kitpvp.game 16
execute store success score #li_b kitpvp.game if predicate kitpvp:random/1in2
execute if score #li_b kitpvp.game matches 1 run scoreboard players add #li_r4 kitpvp.game 32
execute store success score #li_b kitpvp.game if predicate kitpvp:random/1in2
execute if score #li_b kitpvp.game matches 1 run scoreboard players add #li_r4 kitpvp.game 64
execute store success score #li_b kitpvp.game if predicate kitpvp:random/1in2
execute if score #li_b kitpvp.game matches 1 run scoreboard players add #li_r4 kitpvp.game 128
execute store success score #li_b kitpvp.game if predicate kitpvp:random/1in2
execute if score #li_b kitpvp.game matches 1 run scoreboard players add #li_r4 kitpvp.game 256
execute store success score #li_b kitpvp.game if predicate kitpvp:random/1in2
execute if score #li_b kitpvp.game matches 1 run scoreboard players add #li_r4 kitpvp.game 512
execute if score #li_r kitpvp.game < #li_t kitpvp.game run scoreboard players set @s kitpvp.li_pity 0
execute if score #li_r kitpvp.game < #li_t kitpvp.game run function kitpvp:skill/li_ench/pull_jackpot
execute unless score #li_r kitpvp.game < #li_t kitpvp.game run scoreboard players add @s kitpvp.li_pity 1
execute unless score #li_r kitpvp.game < #li_t kitpvp.game if score #li_r4 kitpvp.game matches 0..101 run function kitpvp:skill/li_ench/pull_four
execute unless score #li_r kitpvp.game < #li_t kitpvp.game if score #li_r4 kitpvp.game matches 102.. run function kitpvp:skill/li_ench/pull_charge
