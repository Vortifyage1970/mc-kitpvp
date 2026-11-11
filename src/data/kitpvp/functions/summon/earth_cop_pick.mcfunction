# 三个交警共用一个池号（28）：先 1in3 定是不是普通交警，剩下 2/3 再五五开
# 只掷一次、结果存分数，避免 if/unless 各掷一次出现"两只都没召"或"召了两只"
scoreboard players set #cop_pick kitpvp.game 0
execute store success score #cop_pick kitpvp.game run predicate kitpvp:random/1in3
execute if score #cop_pick kitpvp.game matches 1 run function kitpvp:summon/earth_cop
execute if score #cop_pick kitpvp.game matches 0 run function kitpvp:summon/earth_cop_pick_b
