# revoke 是铁律：不 revoke，下次捡弓不再触发
execute if score @s kitpvp.kit matches 2 run function kitpvp:skill/archer_refill

execute unless score @s kitpvp.kit matches 2 run function kitpvp:skill/archer_steal

advancement revoke @s only kitpvp:player/archer_pickup
