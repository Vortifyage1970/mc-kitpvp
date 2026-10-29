# 地球魂石的队槽识别：命令里读不到"一个实体属于哪个队"，只能逐队比对
# 压成一个编号写进 #steam：1..6 幽灵 / 7..12 炮台 / 13..18 里·驯兽师 / 19..24 地球 / 0 不在任何队
# 24 行是机械展开，队伍表只有这 4 套 × 6 槽（见 load）；以后加队槽在这里同步追加即可
scoreboard players set #steam kitpvp.game 0
execute if entity @s[team=ghost_1] run scoreboard players set #steam kitpvp.game 1
execute if entity @s[team=ghost_2] run scoreboard players set #steam kitpvp.game 2
execute if entity @s[team=ghost_3] run scoreboard players set #steam kitpvp.game 3
execute if entity @s[team=ghost_4] run scoreboard players set #steam kitpvp.game 4
execute if entity @s[team=ghost_5] run scoreboard players set #steam kitpvp.game 5
execute if entity @s[team=ghost_6] run scoreboard players set #steam kitpvp.game 6
execute if entity @s[team=turret_1] run scoreboard players set #steam kitpvp.game 7
execute if entity @s[team=turret_2] run scoreboard players set #steam kitpvp.game 8
execute if entity @s[team=turret_3] run scoreboard players set #steam kitpvp.game 9
execute if entity @s[team=turret_4] run scoreboard players set #steam kitpvp.game 10
execute if entity @s[team=turret_5] run scoreboard players set #steam kitpvp.game 11
execute if entity @s[team=turret_6] run scoreboard players set #steam kitpvp.game 12
execute if entity @s[team=ttamer_1] run scoreboard players set #steam kitpvp.game 13
execute if entity @s[team=ttamer_2] run scoreboard players set #steam kitpvp.game 14
execute if entity @s[team=ttamer_3] run scoreboard players set #steam kitpvp.game 15
execute if entity @s[team=ttamer_4] run scoreboard players set #steam kitpvp.game 16
execute if entity @s[team=ttamer_5] run scoreboard players set #steam kitpvp.game 17
execute if entity @s[team=ttamer_6] run scoreboard players set #steam kitpvp.game 18
execute if entity @s[team=earth_1] run scoreboard players set #steam kitpvp.game 19
execute if entity @s[team=earth_2] run scoreboard players set #steam kitpvp.game 20
execute if entity @s[team=earth_3] run scoreboard players set #steam kitpvp.game 21
execute if entity @s[team=earth_4] run scoreboard players set #steam kitpvp.game 22
execute if entity @s[team=earth_5] run scoreboard players set #steam kitpvp.game 23
execute if entity @s[team=earth_6] run scoreboard players set #steam kitpvp.game 24

# 不在任何队：给他分一个地球槽（复用地球职业那套 link），编号落在 19..24
execute if score #steam kitpvp.game matches 0 run function kitpvp:skill/earth/link
execute if score #steam kitpvp.game matches 0 run scoreboard players operation #steam kitpvp.game = @s kitpvp.etid
execute if score #steam kitpvp.game matches 1..6 run scoreboard players add #steam kitpvp.game 18
# link 都没分到槽（极端情况）：退回 19（earth_1），至少不会和幽灵/炮台编号撞
execute if score #steam kitpvp.game matches 0 run scoreboard players set #steam kitpvp.game 19
