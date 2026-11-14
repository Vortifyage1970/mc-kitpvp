# 从已注册地图随机选一张，结果写 #global kitpvp.map（1 沙漠 / 2 竞技场 / 3 雪原 / 7 地球 / 8 西安 / 9 豪宅 / 10 君士坦丁堡 / 11 多伦多）
# 1.20.1 无 /random：与 kit/random 同法（1in2 连掷 7 次拼 0..127 再取模）。
# 掷数必须够多：只掷 2 次只有 0..3，池子一超过 4 张就有地图永远抽不到。
# 新增地图时改 #pool_size 并在末尾追加一行映射。
scoreboard players set #pool_size kitpvp.game 8

scoreboard players set #rng kitpvp.game 0
execute if predicate kitpvp:random/1in2 run scoreboard players add #rng kitpvp.game 1
execute if predicate kitpvp:random/1in2 run scoreboard players add #rng kitpvp.game 2
execute if predicate kitpvp:random/1in2 run scoreboard players add #rng kitpvp.game 4
execute if predicate kitpvp:random/1in2 run scoreboard players add #rng kitpvp.game 8
execute if predicate kitpvp:random/1in2 run scoreboard players add #rng kitpvp.game 16
execute if predicate kitpvp:random/1in2 run scoreboard players add #rng kitpvp.game 32
execute if predicate kitpvp:random/1in2 run scoreboard players add #rng kitpvp.game 64

scoreboard players operation #rng kitpvp.game %= #pool_size kitpvp.game

execute if score #rng kitpvp.game matches 0 run scoreboard players set #global kitpvp.map 1
execute if score #rng kitpvp.game matches 1 run scoreboard players set #global kitpvp.map 2
execute if score #rng kitpvp.game matches 2 run scoreboard players set #global kitpvp.map 3
execute if score #rng kitpvp.game matches 3 run scoreboard players set #global kitpvp.map 7
execute if score #rng kitpvp.game matches 4 run scoreboard players set #global kitpvp.map 8
execute if score #rng kitpvp.game matches 5 run scoreboard players set #global kitpvp.map 9
execute if score #rng kitpvp.game matches 6 run scoreboard players set #global kitpvp.map 10
execute if score #rng kitpvp.game matches 7 run scoreboard players set #global kitpvp.map 11
