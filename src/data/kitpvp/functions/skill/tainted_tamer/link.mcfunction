# 召唤物归属：队槽只用于"不攻击召唤者"，玩家与召唤物必须都进同一队（见 04 §五）
# 玩家留在队里不影响互相伤害：team 的 friendlyFire 默认 true 只对"同队玩家"开放攻击
# 补零：中途加入的玩家没有这个分数，不加这一步 matches 0 永远不成立
scoreboard players add @s kitpvp.ttamer_tid 0
execute if score @s kitpvp.ttamer_tid matches 0 run scoreboard players add #ttamer kitpvp.game 1
execute if score @s kitpvp.ttamer_tid matches 0 if score #ttamer kitpvp.game matches 7.. run scoreboard players set #ttamer kitpvp.game 1
execute if score @s kitpvp.ttamer_tid matches 0 run scoreboard players operation @s kitpvp.ttamer_tid = #ttamer kitpvp.game

execute if score @s kitpvp.ttamer_tid matches 1 run team join ttamer_1 @s
execute if score @s kitpvp.ttamer_tid matches 2 run team join ttamer_2 @s
execute if score @s kitpvp.ttamer_tid matches 3 run team join ttamer_3 @s
execute if score @s kitpvp.ttamer_tid matches 4 run team join ttamer_4 @s
execute if score @s kitpvp.ttamer_tid matches 5 run team join ttamer_5 @s
execute if score @s kitpvp.ttamer_tid matches 6 run team join ttamer_6 @s

execute if score @s kitpvp.ttamer_tid matches 1 run team join ttamer_1 @e[tag=kitpvp.tt_minion_new]
execute if score @s kitpvp.ttamer_tid matches 2 run team join ttamer_2 @e[tag=kitpvp.tt_minion_new]
execute if score @s kitpvp.ttamer_tid matches 3 run team join ttamer_3 @e[tag=kitpvp.tt_minion_new]
execute if score @s kitpvp.ttamer_tid matches 4 run team join ttamer_4 @e[tag=kitpvp.tt_minion_new]
execute if score @s kitpvp.ttamer_tid matches 5 run team join ttamer_5 @e[tag=kitpvp.tt_minion_new]
execute if score @s kitpvp.ttamer_tid matches 6 run team join ttamer_6 @e[tag=kitpvp.tt_minion_new]

tag @e remove kitpvp.tt_minion_new
