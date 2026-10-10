# ===== 幽灵魂石：被攻击者左右身侧各召唤一只阴兵，并让阴兵与使用者同队 =====
# @s = 使用者（幽灵玩家）
# 进入本函数时：
#   - 执行位置 / 朝向 = 被攻击者（由上层的 `execute at @s as @a[...]` 保留）
#   - 已确认：使用者激活中、ghost_minion_cd <= 0
#
# ⚠ 本函数内绝对不能再调一次 `at @s` ——
#   那会把位置换成使用者自身的位置，阴兵就会出现在使用者身边而不是被攻击者身边。
#   全程沿用当前执行位置（= 被攻击者）+ `positioned ^x` 表达"左右"。
#   ^x 正值 = 视线左侧 1 格；^x 负值 = 视线右侧 1 格。

tag @e remove kitpvp.ghost_minion_new

# 被攻击者左侧 1.5 格
execute positioned ^1 ^ ^ run function kitpvp:summon/ghost_minion

# 被攻击者右侧 1.5 格
execute positioned ^-1 ^ ^ run function kitpvp:summon/ghost_minion

# --- 队槽分配（1..6 循环复用）---
execute if score @s kitpvp.tid matches 0 run scoreboard players add #ghost_tid kitpvp.game 1
execute if score @s kitpvp.tid matches 0 if score #ghost_tid kitpvp.game matches 7.. run scoreboard players set #ghost_tid kitpvp.game 1
execute if score @s kitpvp.tid matches 0 run scoreboard players operation @s kitpvp.tid = #ghost_tid kitpvp.game

# --- 使用者入队 ---
# 使用者必须也进同一个队，team 的成员关系才成立。
execute if score @s kitpvp.tid matches 1 run team join ghost_1 @s
execute if score @s kitpvp.tid matches 2 run team join ghost_2 @s
execute if score @s kitpvp.tid matches 3 run team join ghost_3 @s
execute if score @s kitpvp.tid matches 4 run team join ghost_4 @s
execute if score @s kitpvp.tid matches 5 run team join ghost_5 @s
execute if score @s kitpvp.tid matches 6 run team join ghost_6 @s

# --- 阴兵入队 ---
execute if score @s kitpvp.tid matches 1 run team join ghost_1 @e[tag=kitpvp.ghost_minion_new]
execute if score @s kitpvp.tid matches 2 run team join ghost_2 @e[tag=kitpvp.ghost_minion_new]
execute if score @s kitpvp.tid matches 3 run team join ghost_3 @e[tag=kitpvp.ghost_minion_new]
execute if score @s kitpvp.tid matches 4 run team join ghost_4 @e[tag=kitpvp.ghost_minion_new]
execute if score @s kitpvp.tid matches 5 run team join ghost_5 @e[tag=kitpvp.ghost_minion_new]
execute if score @s kitpvp.tid matches 6 run team join ghost_6 @e[tag=kitpvp.ghost_minion_new]

# 清掉 new 标记
tag @e remove kitpvp.ghost_minion_new

# 5 秒召唤冷却（100 刻）
scoreboard players set @s kitpvp.ghost_minion_cd 100

title @s actionbar {"text":"阴兵已现（20 秒）","color":"dark_aqua"}

