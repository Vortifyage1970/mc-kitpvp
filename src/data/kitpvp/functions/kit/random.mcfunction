# 1.20.1 无 /random：用 1in2 谓词连掷 7 次拼出 0..127。
# 池须编号连续；新增职业时只改下面两行的数字。
scoreboard players set #pool_size kitpvp.game 9
scoreboard players set #pool_base kitpvp.game 1

scoreboard players set @s kitpvp.rng 0
execute if predicate kitpvp:random/1in2 run scoreboard players add @s kitpvp.rng 1
execute if predicate kitpvp:random/1in2 run scoreboard players add @s kitpvp.rng 2
execute if predicate kitpvp:random/1in2 run scoreboard players add @s kitpvp.rng 4
execute if predicate kitpvp:random/1in2 run scoreboard players add @s kitpvp.rng 8
execute if predicate kitpvp:random/1in2 run scoreboard players add @s kitpvp.rng 16
execute if predicate kitpvp:random/1in2 run scoreboard players add @s kitpvp.rng 32
execute if predicate kitpvp:random/1in2 run scoreboard players add @s kitpvp.rng 64

scoreboard players operation @s kitpvp.rng %= #pool_size kitpvp.game
scoreboard players operation @s kitpvp.rng += #pool_base kitpvp.game
scoreboard players operation @s kitpvp.kit = @s kitpvp.rng

function kitpvp:util/give_kit
