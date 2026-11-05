# 无主电磁炮放电：锁定 15 格内最近的活人，命中点半径 2.5 的结算在 sparky_burst
scoreboard players set @s kitpvp.sparky_charge 0
playsound minecraft:entity.lightning_bolt.thunder master @a[distance=..40] ~ ~ ~ 1.0 1.2
execute if entity @p[distance=..15,gamemode=!spectator,tag=!kitpvp.spectator,nbt=!{Health:0.0f}] at @p[distance=..15,gamemode=!spectator,tag=!kitpvp.spectator,nbt=!{Health:0.0f}] run function kitpvp:skill/earth/sparky_burst
