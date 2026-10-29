function kitpvp:skill/alchemist/clear_splash
scoreboard players set @s kitpvp.cd 1000
title @s actionbar {"text":"迅捷药剂：速度 III（15 秒）","color":"aqua"}
playsound minecraft:entity.splash_potion.throw master @s ~ ~ ~ 0.8 1.0
