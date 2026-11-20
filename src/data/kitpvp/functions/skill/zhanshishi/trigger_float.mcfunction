# 漂浮陷阱：飘浮 XII（amplifier 11）1 秒
execute unless score @s kitpvp.trap_id matches 1 run clear @s minecraft:quartz{KitTrapFloat:1b,KitTrapOwner:1b}
execute unless score @s kitpvp.trap_id matches 2 run clear @s minecraft:quartz{KitTrapFloat:1b,KitTrapOwner:2b}
execute unless score @s kitpvp.trap_id matches 3 run clear @s minecraft:quartz{KitTrapFloat:1b,KitTrapOwner:3b}
execute unless score @s kitpvp.trap_id matches 4 run clear @s minecraft:quartz{KitTrapFloat:1b,KitTrapOwner:4b}
execute unless score @s kitpvp.trap_id matches 5 run clear @s minecraft:quartz{KitTrapFloat:1b,KitTrapOwner:5b}
execute unless score @s kitpvp.trap_id matches 6 run clear @s minecraft:quartz{KitTrapFloat:1b,KitTrapOwner:6b}
effect give @s minecraft:levitation 1 11 true
title @s actionbar {"text":"踩中了漂浮陷阱！","color":"aqua"}
playsound minecraft:entity.shulker_bullet.hit master @s ~ ~ ~ 1 1.4
