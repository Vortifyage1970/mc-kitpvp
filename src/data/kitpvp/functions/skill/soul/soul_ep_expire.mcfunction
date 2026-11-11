# 魂石到期：收回枪、关掉红/紫门、熄灭两条灯
tag @s remove kitpvp.soul_ep_active
clear @s minecraft:spyglass{KitPortalGunSoul:1b}
scoreboard players set @s kitpvp.soul_ep_timer 0
kill @e[tag=kitpvp.tep_r]
kill @e[tag=kitpvp.tep_p]
bossbar set kitpvp:tep_hud_red name {"text":"□ 红门","color":"dark_gray"}
bossbar set kitpvp:tep_hud_red color white
bossbar set kitpvp:tep_hud_red value 0
bossbar set kitpvp:tep_hud_purple name {"text":"□ 紫门","color":"dark_gray"}
bossbar set kitpvp:tep_hud_purple color white
bossbar set kitpvp:tep_hud_purple value 0
title @s actionbar {"text":"魂石·传送已消散","color":"gray"}
playsound minecraft:block.end_portal_frame.break master @s ~ ~ ~ 0.7 1.2
