scoreboard players set @s kitpvp.poisoner_hit_cd 24
# 临时 tag 在同一函数里同步加 / 删；3 格内除自己以外的玩家挨个结算
tag @s add kitpvp.poisoner_self
# 先记血量（×10 精确到半心）：≤60（3 颗心）→ 斩杀；否则上毒
execute at @s as @e[type=minecraft:player,distance=..3,tag=!kitpvp.poisoner_self,tag=!kitpvp.spectator] store result score @s kitpvp.tmp run data get entity @s Health 10
execute at @s as @e[type=minecraft:player,distance=..3,tag=!kitpvp.poisoner_self,tag=!kitpvp.spectator] if score @s kitpvp.tmp matches ..60 run function kitpvp:skill/poisoner/execute_hit
execute at @s as @e[type=minecraft:player,distance=..3,tag=!kitpvp.poisoner_self,tag=!kitpvp.spectator] if score @s kitpvp.tmp matches 61.. run effect give @s minecraft:poison 6 1 true
tag @s remove kitpvp.poisoner_self
