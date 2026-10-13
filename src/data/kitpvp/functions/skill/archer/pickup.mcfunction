# revoke 是铁律：不 revoke，下次捡弓不再触发
execute if score @s kitpvp.kit matches 2 run function kitpvp:skill/archer/refill

execute unless score @s kitpvp.kit matches 2 run function kitpvp:skill/archer/steal

advancement revoke @s only kitpvp:player/archer_pickup
