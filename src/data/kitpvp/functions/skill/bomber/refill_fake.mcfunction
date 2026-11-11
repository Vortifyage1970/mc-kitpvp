# 假核弹：上限 1、每 20 秒（400 刻）补 1（与大炸弹各算各的补货）
scoreboard players set @s kitpvp.tmp 0
execute store result score @s kitpvp.tmp run clear @s minecraft:mooshroom_spawn_egg{KitBombFake:1b} 0
execute if score @s kitpvp.tmp matches ..0 run function kitpvp:skill/bomber/give_fake
execute if score @s kitpvp.tmp matches ..0 run scoreboard players set @s kitpvp.bomb_fake_cd 400
execute if score @s kitpvp.tmp matches ..0 run title @s actionbar {"text":"补给：假核弹 +1","color":"gold"}
