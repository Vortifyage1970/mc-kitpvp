# @s = Sheepass：每 10 秒给 20 格内所有玩家 20 秒反胃
execute as @a[distance=..20,scores={kitpvp.alive=1},tag=!kitpvp.spectator] run effect give @s minecraft:nausea 20 0 true
playsound minecraft:entity.sheep.ambient master @a[distance=..20] ~ ~ ~ 1.0 0.9
scoreboard players set @s kitpvp.earth_cd_a 200
