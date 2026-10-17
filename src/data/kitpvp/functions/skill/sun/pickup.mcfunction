# 日冕物质抛射的换弹：捡回自己的弓就换弹，捡别人的弓没收（同弓箭手 / 里·弓箭手）。

# revoke 是铁律：不 revoke，下次捡弓不再触发
execute if score @s kitpvp.kit matches 65 if score @s kitpvp.sun_reload matches ..0 run function kitpvp:skill/sun/refill
execute if score @s kitpvp.kit matches 65 if score @s kitpvp.sun_reload matches 1.. run title @s actionbar {"text":"换弹冷却中","color":"gray"}

execute unless score @s kitpvp.kit matches 65 run function kitpvp:skill/sun/steal

advancement revoke @s only kitpvp:player/sun_bow_pickup
