# 1.20.1 无 /random：用 1in2 谓词连掷 7 次拼出 0..127，取模得到池内序号（0..pool_size-1）。
# 序号到真实编号的映射写在末尾——表职业 1..11 与 18、里职业 23..25 与 27，编号不连续也能进池。
# 新增职业时改 #pool_size 并在末尾追加一行映射。
scoreboard players set #pool_size kitpvp.game 16

scoreboard players set @s kitpvp.rng 0
execute if predicate kitpvp:random/1in2 run scoreboard players add @s kitpvp.rng 1
execute if predicate kitpvp:random/1in2 run scoreboard players add @s kitpvp.rng 2
execute if predicate kitpvp:random/1in2 run scoreboard players add @s kitpvp.rng 4
execute if predicate kitpvp:random/1in2 run scoreboard players add @s kitpvp.rng 8
execute if predicate kitpvp:random/1in2 run scoreboard players add @s kitpvp.rng 16
execute if predicate kitpvp:random/1in2 run scoreboard players add @s kitpvp.rng 32
execute if predicate kitpvp:random/1in2 run scoreboard players add @s kitpvp.rng 64

scoreboard players operation @s kitpvp.rng %= #pool_size kitpvp.game

execute if score @s kitpvp.rng matches 0 run scoreboard players set @s kitpvp.kit 1
execute if score @s kitpvp.rng matches 1 run scoreboard players set @s kitpvp.kit 2
execute if score @s kitpvp.rng matches 2 run scoreboard players set @s kitpvp.kit 3
execute if score @s kitpvp.rng matches 3 run scoreboard players set @s kitpvp.kit 4
execute if score @s kitpvp.rng matches 4 run scoreboard players set @s kitpvp.kit 5
execute if score @s kitpvp.rng matches 5 run scoreboard players set @s kitpvp.kit 6
execute if score @s kitpvp.rng matches 6 run scoreboard players set @s kitpvp.kit 7
execute if score @s kitpvp.rng matches 7 run scoreboard players set @s kitpvp.kit 8
execute if score @s kitpvp.rng matches 8 run scoreboard players set @s kitpvp.kit 9
execute if score @s kitpvp.rng matches 9 run scoreboard players set @s kitpvp.kit 10
execute if score @s kitpvp.rng matches 10 run scoreboard players set @s kitpvp.kit 11
execute if score @s kitpvp.rng matches 11 run scoreboard players set @s kitpvp.kit 18
execute if score @s kitpvp.rng matches 12 run scoreboard players set @s kitpvp.kit 23
execute if score @s kitpvp.rng matches 13 run scoreboard players set @s kitpvp.kit 24
execute if score @s kitpvp.rng matches 14 run scoreboard players set @s kitpvp.kit 25
execute if score @s kitpvp.rng matches 15 run scoreboard players set @s kitpvp.kit 27

function kitpvp:util/give_kit
