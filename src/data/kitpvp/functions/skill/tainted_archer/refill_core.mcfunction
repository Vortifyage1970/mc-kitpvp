# 熔火核心：上限 1、120 秒（2400 刻）；使用侧 core_fire 起计
scoreboard players set @s kitpvp.tmp 0
execute store result score @s kitpvp.tmp run clear @s minecraft:blaze_spawn_egg{KitTaintedCoreEgg:1b} 0
execute if score @s kitpvp.tmp matches ..0 run function kitpvp:skill/tainted_archer/give_token_core
execute if score @s kitpvp.tmp matches ..0 run scoreboard players set @s kitpvp.cd2 2400
execute if score @s kitpvp.tmp matches ..0 run title @s actionbar {"text":"熔火核心已就绪","color":"gold"}
execute if score @s kitpvp.tmp matches ..0 run playsound minecraft:entity.blaze.ambient master @s ~ ~ ~ 0.6 1.2
