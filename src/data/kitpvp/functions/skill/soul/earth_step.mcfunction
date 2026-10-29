# 地球魂石：每 10 刻在标记处召一只（@s = 标记，执行位置 = 标记）
function kitpvp:skill/earth/random

# 认标记的主人：earth_owner 是主人落点时的 etid，6 行按队把这只生灵拉进同一队
execute if score @s kitpvp.earth_owner matches 1 run team join earth_1 @e[tag=kitpvp.earth_minion_new,distance=..4]
execute if score @s kitpvp.earth_owner matches 2 run team join earth_2 @e[tag=kitpvp.earth_minion_new,distance=..4]
execute if score @s kitpvp.earth_owner matches 3 run team join earth_3 @e[tag=kitpvp.earth_minion_new,distance=..4]
execute if score @s kitpvp.earth_owner matches 4 run team join earth_4 @e[tag=kitpvp.earth_minion_new,distance=..4]
execute if score @s kitpvp.earth_owner matches 5 run team join earth_5 @e[tag=kitpvp.earth_minion_new,distance=..4]
execute if score @s kitpvp.earth_owner matches 6 run team join earth_6 @e[tag=kitpvp.earth_minion_new,distance=..4]
tag @e[tag=kitpvp.earth_minion_new,distance=..4] remove kitpvp.earth_minion_new

# 下一只 10 刻后；4 只发完就把标记清掉
scoreboard players set @s kitpvp.earth_cd_a 10
scoreboard players remove @s kitpvp.earth_life 10
execute if score @s kitpvp.earth_life matches ..0 run kill @s
