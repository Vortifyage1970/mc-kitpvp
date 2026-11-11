# 两个超凡升天共用一个池号（14）：五五开
# 只掷一次、结果存分数，避免 if/unless 各掷一次出现"两只都没召"或"召了两只"
scoreboard players set #ascend_pick kitpvp.game 0
execute store success score #ascend_pick kitpvp.game run predicate kitpvp:random/1in2
execute if score #ascend_pick kitpvp.game matches 1 run function kitpvp:summon/earth_ascend
execute if score #ascend_pick kitpvp.game matches 0 run function kitpvp:summon/earth_ascend2
