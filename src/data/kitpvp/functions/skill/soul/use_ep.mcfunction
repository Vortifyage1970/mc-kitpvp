# 末影人魂石：给一把"魂石·传送枪"（红门 / 紫门，冷却 0.5 秒），20 秒后收回
scoreboard players operation @s kitpvp.soul_ep_last = @s kitpvp.soul_ep_used
give @s minecraft:spyglass{KitPortalGun:1b,KitPortalGunSoul:1b,Unbreakable:1b,display:{Name:'{"text":"魂石·传送枪","color":"light_purple"}'}} 1
tag @s add kitpvp.soul_ep_active
scoreboard players set @s kitpvp.soul_ep_timer 400
scoreboard players set @s kitpvp.tep_cd_s 0
title @s actionbar {"text":"魂石·传送：红门 / 紫门（20 秒）","color":"light_purple"}
playsound minecraft:block.end_portal.spawn master @s ~ ~ ~ 0.7 1.4
