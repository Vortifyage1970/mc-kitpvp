# 猛毒陷阱：中毒 II 10 秒 + 挖掘疲劳 II 10 秒 + 虚弱 10 秒
execute unless score @s kitpvp.trap_id matches 1 run clear @s minecraft:spider_eye{KitTrapPoison:1b,KitTrapOwner:1b}
execute unless score @s kitpvp.trap_id matches 2 run clear @s minecraft:spider_eye{KitTrapPoison:1b,KitTrapOwner:2b}
execute unless score @s kitpvp.trap_id matches 3 run clear @s minecraft:spider_eye{KitTrapPoison:1b,KitTrapOwner:3b}
execute unless score @s kitpvp.trap_id matches 4 run clear @s minecraft:spider_eye{KitTrapPoison:1b,KitTrapOwner:4b}
execute unless score @s kitpvp.trap_id matches 5 run clear @s minecraft:spider_eye{KitTrapPoison:1b,KitTrapOwner:5b}
execute unless score @s kitpvp.trap_id matches 6 run clear @s minecraft:spider_eye{KitTrapPoison:1b,KitTrapOwner:6b}
effect give @s minecraft:poison 10 1 true
effect give @s minecraft:mining_fatigue 10 1 true
effect give @s minecraft:weakness 10 0 true
title @s actionbar {"text":"踩中了猛毒陷阱！","color":"dark_green"}
playsound minecraft:entity.spider.ambient master @s ~ ~ ~ 1 0.6
