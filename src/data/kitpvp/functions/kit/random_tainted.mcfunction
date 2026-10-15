# 里职业池随机：与 kit/random 同法（1in2 连掷 7 次拼 0..127 再取模），池子只有经典（里）。
# 新增里职业时改 #pool_size 并在末尾追加一行映射（见 06 §一）。
scoreboard players set #pool_size kitpvp.game 5

scoreboard players set @s kitpvp.rng 0
execute if predicate kitpvp:random/1in2 run scoreboard players add @s kitpvp.rng 1
execute if predicate kitpvp:random/1in2 run scoreboard players add @s kitpvp.rng 2
execute if predicate kitpvp:random/1in2 run scoreboard players add @s kitpvp.rng 4
execute if predicate kitpvp:random/1in2 run scoreboard players add @s kitpvp.rng 8
execute if predicate kitpvp:random/1in2 run scoreboard players add @s kitpvp.rng 16
execute if predicate kitpvp:random/1in2 run scoreboard players add @s kitpvp.rng 32
execute if predicate kitpvp:random/1in2 run scoreboard players add @s kitpvp.rng 64

scoreboard players operation @s kitpvp.rng %= #pool_size kitpvp.game

execute if score @s kitpvp.rng matches 0 run scoreboard players set @s kitpvp.kit 23
execute if score @s kitpvp.rng matches 1 run scoreboard players set @s kitpvp.kit 24
execute if score @s kitpvp.rng matches 2 run scoreboard players set @s kitpvp.kit 25
execute if score @s kitpvp.rng matches 3 run scoreboard players set @s kitpvp.kit 27
execute if score @s kitpvp.rng matches 4 run scoreboard players set @s kitpvp.kit 29

function kitpvp:util/give_kit
