# 从已注册地图随机选一张，结果写 #global kitpvp.map（1 沙漠 / 2 竞技场 / 7 地球 / 8 西安）
# 1.20.1 无 /random：用 1in2 谓词连掷拼随机数。新增地图时改 #pool_size 并在末尾追加一行映射。
scoreboard players set #pool_size kitpvp.game 4

scoreboard players set #rng kitpvp.game 0
execute if predicate kitpvp:random/1in2 run scoreboard players add #rng kitpvp.game 1
execute if predicate kitpvp:random/1in2 run scoreboard players add #rng kitpvp.game 2

scoreboard players operation #rng kitpvp.game %= #pool_size kitpvp.game

execute if score #rng kitpvp.game matches 0 run scoreboard players set #global kitpvp.map 1
execute if score #rng kitpvp.game matches 1 run scoreboard players set #global kitpvp.map 2
execute if score #rng kitpvp.game matches 2 run scoreboard players set #global kitpvp.map 7
execute if score #rng kitpvp.game matches 3 run scoreboard players set #global kitpvp.map 8
