# revoke 是铁律：不 revoke，下次捡弓不再触发
execute if score @s kitpvp.kit matches 24 run function kitpvp:skill/taint_archer/refill_bow

execute unless score @s kitpvp.kit matches 24 run function kitpvp:skill/taint_archer/steal_bow

advancement revoke @s only kitpvp:player/taint_bow_pickup
