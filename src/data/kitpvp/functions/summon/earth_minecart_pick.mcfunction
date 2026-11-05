# 矿车这一号出率一分为二：掷一次 1in2 决定召哪只（各 50%）
# ★ 只掷一次、把结果存成分数：写成 if predicate … / unless predicate … 会各掷一次，
#   那样会出现"两只都召"或"一只都没召"的窟窿
scoreboard players set #mc_pick kitpvp.game -1
execute store success score #mc_pick kitpvp.game if predicate kitpvp:random/1in2
execute if score #mc_pick kitpvp.game matches 1 run function kitpvp:summon/earth_minecart
execute if score #mc_pick kitpvp.game matches 0 run function kitpvp:summon/earth_minecart_plain
