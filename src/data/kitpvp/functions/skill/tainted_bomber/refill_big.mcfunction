# 大炸弹：上限 4、每 20 秒（400 刻）补 1
scoreboard players set @s kitpvp.tmp 0
execute store result score @s kitpvp.tmp run clear @s minecraft:mooshroom_spawn_egg{KitBombBig:1b} 0
execute if score @s kitpvp.tmp matches ..3 run function kitpvp:skill/bomber/give_big
execute if score @s kitpvp.tmp matches ..3 run scoreboard players set @s kitpvp.bomb_big_cd 400
execute if score @s kitpvp.tmp matches ..3 run title @s actionbar {"text":"补给：大炸弹 +1","color":"gold"}
