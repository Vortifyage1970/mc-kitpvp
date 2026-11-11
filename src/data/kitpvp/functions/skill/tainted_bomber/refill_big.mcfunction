# 大炸弹：上限 5、每 10 秒（200 刻）补 1
scoreboard players set @s kitpvp.tmp 0
execute store result score @s kitpvp.tmp run clear @s minecraft:mooshroom_spawn_egg{KitBombBig:1b} 0
execute if score @s kitpvp.tmp matches ..4 run function kitpvp:skill/bomber/give_big
execute if score @s kitpvp.tmp matches ..4 run scoreboard players set @s kitpvp.bomb_big_cd 200
execute if score @s kitpvp.tmp matches ..4 run title @s actionbar {"text":"补给：大炸弹 +1","color":"gold"}
