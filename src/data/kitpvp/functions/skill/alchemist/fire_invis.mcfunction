function kitpvp:skill/alchemist/clear_splash
scoreboard players set @s kitpvp.cd 1000
title @s actionbar {"text":"隐匿药剂：隐身 I（20 秒）","color":"gray"}
playsound minecraft:entity.splash_potion.throw master @s ~ ~ ~ 0.8 1.0
