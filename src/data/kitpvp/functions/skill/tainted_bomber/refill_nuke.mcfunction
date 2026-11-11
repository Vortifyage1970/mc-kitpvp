# 核弹：上限 5、每 15 秒（300 刻）补 1
scoreboard players set @s kitpvp.tmp 0
execute store result score @s kitpvp.tmp run clear @s minecraft:mooshroom_spawn_egg{KitBombNuke:1b} 0
execute if score @s kitpvp.tmp matches ..4 run function kitpvp:skill/bomber/give_nuke
execute if score @s kitpvp.tmp matches ..4 run scoreboard players set @s kitpvp.bomb_nuke_cd 300
execute if score @s kitpvp.tmp matches ..4 run title @s actionbar {"text":"补给：核弹 +1","color":"dark_red"}
