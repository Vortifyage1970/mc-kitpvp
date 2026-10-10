# ===== 幽灵魂石：把刚召唤的阴兵挂到使用者名下 =====
# @s = 幽灵使用者（由 skill/soul/ghost_hurt 用 as @a[tag=kitpvp.soul_ghost_active,sort=nearest,limit=1] 切进来）
# 进入本函数时：@e[tag=kitpvp.ghost_minion_new] = 刚召唤的那一两只阴兵
#
# 本函数做三件事：
#   1. 惰性分配队槽 tid（1..6），循环复用
#   2. 使用者自己 + 阴兵都加入 ghost_<tid> 队（friendlyFire=false → 阴兵不攻击主人）
#   3. 使用者进入 5 秒召唤冷却

# --- 1. 惰性分配 tid ---
# 用 #ghost_need_new 记录"这名使用者本次是否需要新 tid"
scoreboard players set #ghost_need_new kitpvp.game 0
execute if score @s kitpvp.tid matches 0 run scoreboard players set #ghost_need_new kitpvp.game 1
execute if score #ghost_need_new kitpvp.game matches 1 run scoreboard players operation @s kitpvp.tid = #ghost_tid kitpvp.game
execute if score #ghost_need_new kitpvp.game matches 1 run scoreboard players add #ghost_tid kitpvp.game 1
# 循环回 1（3-6 人规模，6 个队槽够用；超了会复用队槽）
execute if score #ghost_need_new kitpvp.game matches 1 if score #ghost_tid kitpvp.game matches 7.. run scoreboard players set #ghost_tid kitpvp.game 1

# --- 2a. 使用者入队 ---
execute if score @s kitpvp.tid matches 1 run team join ghost_1 @s
execute if score @s kitpvp.tid matches 2 run team join ghost_2 @s
execute if score @s kitpvp.tid matches 3 run team join ghost_3 @s
execute if score @s kitpvp.tid matches 4 run team join ghost_4 @s
execute if score @s kitpvp.tid matches 5 run team join ghost_5 @s
execute if score @s kitpvp.tid matches 6 run team join ghost_6 @s

# --- 2b. 阴兵入队 ---
execute if score @s kitpvp.tid matches 1 run team join ghost_1 @e[tag=kitpvp.ghost_minion_new]
execute if score @s kitpvp.tid matches 2 run team join ghost_2 @e[tag=kitpvp.ghost_minion_new]
execute if score @s kitpvp.tid matches 3 run team join ghost_3 @e[tag=kitpvp.ghost_minion_new]
execute if score @s kitpvp.tid matches 4 run team join ghost_4 @e[tag=kitpvp.ghost_minion_new]
execute if score @s kitpvp.tid matches 5 run team join ghost_5 @e[tag=kitpvp.ghost_minion_new]
execute if score @s kitpvp.tid matches 6 run team join ghost_6 @e[tag=kitpvp.ghost_minion_new]

# --- 3. 5 秒召唤冷却（100 刻）---
scoreboard players set @s kitpvp.ghost_minion_cd 100
