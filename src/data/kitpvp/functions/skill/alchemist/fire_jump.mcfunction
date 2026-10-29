function kitpvp:skill/alchemist/clear_splash
scoreboard players set @s kitpvp.cd 1000
title @s actionbar {"text":"跳跃药剂：跳跃提升 X（10 秒）","color":"green"}
playsound minecraft:entity.splash_potion.throw master @s ~ ~ ~ 0.8 1.0
