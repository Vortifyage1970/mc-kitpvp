# 由 follow 调用（@s = 本体）：把属于本体的鹦鹉放上自己的背
# 玩家身上最多挂一只鹦鹉，所以"已经骑着"由调用方用 Passengers 判断，不必在这里重复判断
tag @s add kitpvp.pluto_self
execute as @e[type=minecraft:parrot,tag=kitpvp.pluto_parrot] if score @s kitpvp.parrot_owner = #ptid kitpvp.game run ride @s mount @e[tag=kitpvp.pluto_self,limit=1]
tag @s remove kitpvp.pluto_self
