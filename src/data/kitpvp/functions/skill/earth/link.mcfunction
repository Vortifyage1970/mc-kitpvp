# 召唤物归属：队槽只用于"不攻击召唤者"，玩家与召唤物必须都进同一队（见 04 §五）
# 补零：中途加入的玩家没有这个分数，不加这一步 matches 0 永远不成立
scoreboard players add @s kitpvp.etid 0

# 自己的槽位已被另一名玩家占用（重载 / 中途加入留下的旧编号）就作废重选，避免两人同队互不攻击
scoreboard players operation #pl kitpvp.game = @s kitpvp.etid
scoreboard players set #same kitpvp.game 0
execute if score @s kitpvp.etid matches 1.. as @a if score @s kitpvp.etid = #pl kitpvp.game run scoreboard players add #same kitpvp.game 1
execute if score #same kitpvp.game matches 2.. run scoreboard players set @s kitpvp.etid 0

# 选槽：取 1..6 里第一个没被其他玩家占用的槽位。此刻 @s 的 etid 还是 0，不会被算成占用者
execute if score @s kitpvp.etid matches 0 run scoreboard players set #eslot kitpvp.game 1
execute if score @s kitpvp.etid matches 0 if entity @a[scores={kitpvp.etid=1}] run scoreboard players set #eslot kitpvp.game 2
execute if score @s kitpvp.etid matches 0 if score #eslot kitpvp.game matches 2 if entity @a[scores={kitpvp.etid=2}] run scoreboard players set #eslot kitpvp.game 3
execute if score @s kitpvp.etid matches 0 if score #eslot kitpvp.game matches 3 if entity @a[scores={kitpvp.etid=3}] run scoreboard players set #eslot kitpvp.game 4
execute if score @s kitpvp.etid matches 0 if score #eslot kitpvp.game matches 4 if entity @a[scores={kitpvp.etid=4}] run scoreboard players set #eslot kitpvp.game 5
execute if score @s kitpvp.etid matches 0 if score #eslot kitpvp.game matches 5 if entity @a[scores={kitpvp.etid=5}] run scoreboard players set #eslot kitpvp.game 6
execute if score @s kitpvp.etid matches 0 run scoreboard players operation @s kitpvp.etid = #eslot kitpvp.game

execute if score @s kitpvp.etid matches 1 run team join earth_1 @s
execute if score @s kitpvp.etid matches 2 run team join earth_2 @s
execute if score @s kitpvp.etid matches 3 run team join earth_3 @s
execute if score @s kitpvp.etid matches 4 run team join earth_4 @s
execute if score @s kitpvp.etid matches 5 run team join earth_5 @s
execute if score @s kitpvp.etid matches 6 run team join earth_6 @s

# 只认领这次召唤落在脚下的生灵（距离以召唤落点为原点），不碰别人的召唤物
execute if score @s kitpvp.etid matches 1 run team join earth_1 @e[tag=kitpvp.earth_minion_new,distance=..4]
execute if score @s kitpvp.etid matches 2 run team join earth_2 @e[tag=kitpvp.earth_minion_new,distance=..4]
execute if score @s kitpvp.etid matches 3 run team join earth_3 @e[tag=kitpvp.earth_minion_new,distance=..4]
execute if score @s kitpvp.etid matches 4 run team join earth_4 @e[tag=kitpvp.earth_minion_new,distance=..4]
execute if score @s kitpvp.etid matches 5 run team join earth_5 @e[tag=kitpvp.earth_minion_new,distance=..4]
execute if score @s kitpvp.etid matches 6 run team join earth_6 @e[tag=kitpvp.earth_minion_new,distance=..4]

tag @e remove kitpvp.earth_minion_new
