# 绊索陷阱：拆掉别人那一个，捡起者吃 缓慢 III 5 秒 + 失明 5 秒
execute unless score @s kitpvp.trap_id matches 1 run clear @s minecraft:tripwire_hook{KitTrapHook:1b,KitTrapOwner:1b}
execute unless score @s kitpvp.trap_id matches 2 run clear @s minecraft:tripwire_hook{KitTrapHook:1b,KitTrapOwner:2b}
execute unless score @s kitpvp.trap_id matches 3 run clear @s minecraft:tripwire_hook{KitTrapHook:1b,KitTrapOwner:3b}
execute unless score @s kitpvp.trap_id matches 4 run clear @s minecraft:tripwire_hook{KitTrapHook:1b,KitTrapOwner:4b}
execute unless score @s kitpvp.trap_id matches 5 run clear @s minecraft:tripwire_hook{KitTrapHook:1b,KitTrapOwner:5b}
execute unless score @s kitpvp.trap_id matches 6 run clear @s minecraft:tripwire_hook{KitTrapHook:1b,KitTrapOwner:6b}
effect give @s minecraft:slowness 5 2 true
effect give @s minecraft:blindness 5 0 true
title @s actionbar {"text":"踩中了绊索陷阱！","color":"red"}
playsound minecraft:block.tripwire.attach master @s ~ ~ ~ 1 0.8
