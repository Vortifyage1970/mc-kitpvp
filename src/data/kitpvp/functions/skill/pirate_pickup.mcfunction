# 首行 revoke 是铁律：不 revoke，advancement 只会生效一次
advancement revoke @s only kitpvp:player/pirate_pickup

execute if score @s kitpvp.kit matches 9 run function kitpvp:skill/pirate_reload

execute unless score @s kitpvp.kit matches 9 run function kitpvp:skill/pirate_steal
