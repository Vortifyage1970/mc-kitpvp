# 读「这名玩家现在在哪套队」：命令读不到实体所属队伍，只能逐队比对（42 行机械展开，由 out/gen_team_files.py 生成）。
# 编号写进 #steam：
#   1..6    幽灵（阴兵）      7..12   里·弓箭手（炮台）   13..18  里·驯兽师
#   19..24  地球              25..30  炸弹兵              31..36  里·农夫
#   37..42  陷阱师（陷阱虫）  43..    备用
#   0 = 不在任何队
# 加新队槽：load 里 team add → out/gen_team_files.py 的 FAMILIES 加一行 → 重跑（生成 team_index / team_join）
#           → skill/soul/earth_step 追加 6 行进队映射。
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
execute if entity @s[team=bomb_1] run scoreboard players set #steam kitpvp.game 25
execute if entity @s[team=bomb_2] run scoreboard players set #steam kitpvp.game 26
execute if entity @s[team=bomb_3] run scoreboard players set #steam kitpvp.game 27
execute if entity @s[team=bomb_4] run scoreboard players set #steam kitpvp.game 28
execute if entity @s[team=bomb_5] run scoreboard players set #steam kitpvp.game 29
execute if entity @s[team=bomb_6] run scoreboard players set #steam kitpvp.game 30
execute if entity @s[team=farmer_1] run scoreboard players set #steam kitpvp.game 31
execute if entity @s[team=farmer_2] run scoreboard players set #steam kitpvp.game 32
execute if entity @s[team=farmer_3] run scoreboard players set #steam kitpvp.game 33
execute if entity @s[team=farmer_4] run scoreboard players set #steam kitpvp.game 34
execute if entity @s[team=farmer_5] run scoreboard players set #steam kitpvp.game 35
execute if entity @s[team=farmer_6] run scoreboard players set #steam kitpvp.game 36
execute if entity @s[team=trap_1] run scoreboard players set #steam kitpvp.game 37
execute if entity @s[team=trap_2] run scoreboard players set #steam kitpvp.game 38
execute if entity @s[team=trap_3] run scoreboard players set #steam kitpvp.game 39
execute if entity @s[team=trap_4] run scoreboard players set #steam kitpvp.game 40
execute if entity @s[team=trap_5] run scoreboard players set #steam kitpvp.game 41
execute if entity @s[team=trap_6] run scoreboard players set #steam kitpvp.game 42
