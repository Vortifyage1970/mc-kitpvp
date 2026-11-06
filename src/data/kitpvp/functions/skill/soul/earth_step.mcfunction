# 地球魂石：每 10 刻在标记处召一只（@s = 标记，执行位置 = 标记）
function kitpvp:skill/earth/random

# 把这只生灵放进"主人当时所在的那套队"（编号由 earth_team_id 压好，避免换队把他的召唤物变成敌人）
execute if score @s kitpvp.soul_earth_team matches 1 run team join ghost_1 @e[tag=kitpvp.earth_minion_new,distance=..4]
execute if score @s kitpvp.soul_earth_team matches 2 run team join ghost_2 @e[tag=kitpvp.earth_minion_new,distance=..4]
execute if score @s kitpvp.soul_earth_team matches 3 run team join ghost_3 @e[tag=kitpvp.earth_minion_new,distance=..4]
execute if score @s kitpvp.soul_earth_team matches 4 run team join ghost_4 @e[tag=kitpvp.earth_minion_new,distance=..4]
execute if score @s kitpvp.soul_earth_team matches 5 run team join ghost_5 @e[tag=kitpvp.earth_minion_new,distance=..4]
execute if score @s kitpvp.soul_earth_team matches 6 run team join ghost_6 @e[tag=kitpvp.earth_minion_new,distance=..4]
execute if score @s kitpvp.soul_earth_team matches 7 run team join turret_1 @e[tag=kitpvp.earth_minion_new,distance=..4]
execute if score @s kitpvp.soul_earth_team matches 8 run team join turret_2 @e[tag=kitpvp.earth_minion_new,distance=..4]
execute if score @s kitpvp.soul_earth_team matches 9 run team join turret_3 @e[tag=kitpvp.earth_minion_new,distance=..4]
execute if score @s kitpvp.soul_earth_team matches 10 run team join turret_4 @e[tag=kitpvp.earth_minion_new,distance=..4]
execute if score @s kitpvp.soul_earth_team matches 11 run team join turret_5 @e[tag=kitpvp.earth_minion_new,distance=..4]
execute if score @s kitpvp.soul_earth_team matches 12 run team join turret_6 @e[tag=kitpvp.earth_minion_new,distance=..4]
execute if score @s kitpvp.soul_earth_team matches 13 run team join ttamer_1 @e[tag=kitpvp.earth_minion_new,distance=..4]
execute if score @s kitpvp.soul_earth_team matches 14 run team join ttamer_2 @e[tag=kitpvp.earth_minion_new,distance=..4]
execute if score @s kitpvp.soul_earth_team matches 15 run team join ttamer_3 @e[tag=kitpvp.earth_minion_new,distance=..4]
execute if score @s kitpvp.soul_earth_team matches 16 run team join ttamer_4 @e[tag=kitpvp.earth_minion_new,distance=..4]
execute if score @s kitpvp.soul_earth_team matches 17 run team join ttamer_5 @e[tag=kitpvp.earth_minion_new,distance=..4]
execute if score @s kitpvp.soul_earth_team matches 18 run team join ttamer_6 @e[tag=kitpvp.earth_minion_new,distance=..4]
execute if score @s kitpvp.soul_earth_team matches 19 run team join earth_1 @e[tag=kitpvp.earth_minion_new,distance=..4]
execute if score @s kitpvp.soul_earth_team matches 20 run team join earth_2 @e[tag=kitpvp.earth_minion_new,distance=..4]
execute if score @s kitpvp.soul_earth_team matches 21 run team join earth_3 @e[tag=kitpvp.earth_minion_new,distance=..4]
execute if score @s kitpvp.soul_earth_team matches 22 run team join earth_4 @e[tag=kitpvp.earth_minion_new,distance=..4]
execute if score @s kitpvp.soul_earth_team matches 23 run team join earth_5 @e[tag=kitpvp.earth_minion_new,distance=..4]
execute if score @s kitpvp.soul_earth_team matches 24 run team join earth_6 @e[tag=kitpvp.earth_minion_new,distance=..4]
# 把"谁召的"也写进去：深池/变速器/大蜜蜂这些认主人的光环全靠 earth_owner（以前魂石路径只组队、不写分 ⇒ 会被当成无主）
scoreboard players set #soul_owner kitpvp.game 0
execute if score @s kitpvp.soul_earth_team matches 19..24 run scoreboard players operation #soul_owner kitpvp.game = @s kitpvp.soul_earth_team kitpvp.game
# 19..24 是 earth_1..6，减 18 就是那名玩家的 etid
execute if score @s kitpvp.soul_earth_team matches 19..24 run scoreboard players remove #soul_owner kitpvp.game 18
scoreboard players operation @e[tag=kitpvp.earth_minion_new,distance=..4] kitpvp.earth_owner = #soul_owner kitpvp.game
tag @e[tag=kitpvp.earth_minion_new,distance=..4] remove kitpvp.earth_minion_new

# 下一只 10 刻后；4 只发完就把标记清掉
scoreboard players set @s kitpvp.earth_cd_a 10
scoreboard players remove @s kitpvp.earth_life 10
execute if score @s kitpvp.earth_life matches ..0 run kill @s
