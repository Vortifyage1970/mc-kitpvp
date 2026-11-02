# 清掉属于自己的那只鹦鹉（离职业 / 重选 / 淘汰时用）
# 只有 ptid ≥1 才清：没分到号的玩家不去和"别人的 0 号"比较
execute if score @s kitpvp.ptid matches 1.. run scoreboard players operation #ptid kitpvp.game = @s kitpvp.ptid
execute if score @s kitpvp.ptid matches 1.. as @e[type=minecraft:parrot,tag=kitpvp.pluto_parrot] if score @s kitpvp.parrot_owner = #ptid kitpvp.game run kill @s
