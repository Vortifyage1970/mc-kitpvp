# 多肽与 β转角 共用一个池号：五五开（predicate 只掷一次，用 store success 取结果，避免两次 if/unless 各掷一次变成 50/25/25）
execute store success score #pc_pick kitpvp.game run predicate kitpvp:random/1in2
execute if score #pc_pick kitpvp.game matches 1 run function kitpvp:summon/earth_polypeptide
execute if score #pc_pick kitpvp.game matches 0 run function kitpvp:summon/earth_polypeptide_betaturn
