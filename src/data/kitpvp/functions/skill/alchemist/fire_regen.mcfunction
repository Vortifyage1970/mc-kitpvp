function kitpvp:skill/alchemist/clear_splash
scoreboard players set @s kitpvp.cd 1000
title @s actionbar {"text":"再生药剂：生命恢复 II（15 秒）","color":"light_purple"}
playsound minecraft:entity.splash_potion.throw master @s ~ ~ ~ 0.8 1.0
