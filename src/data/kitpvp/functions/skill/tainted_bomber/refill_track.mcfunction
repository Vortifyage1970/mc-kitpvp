# 跟踪炸弹：上限 2、每 15 秒（300 刻）补 1
scoreboard players set @s kitpvp.tmp 0
execute store result score @s kitpvp.tmp run clear @s minecraft:mooshroom_spawn_egg{KitBombTrack:1b} 0
execute if score @s kitpvp.tmp matches ..1 run function kitpvp:skill/bomber/give_track
execute if score @s kitpvp.tmp matches ..1 run scoreboard players set @s kitpvp.bomb_track_cd 300
execute if score @s kitpvp.tmp matches ..1 run title @s actionbar {"text":"补给：跟踪炸弹 +1","color":"dark_red"}
