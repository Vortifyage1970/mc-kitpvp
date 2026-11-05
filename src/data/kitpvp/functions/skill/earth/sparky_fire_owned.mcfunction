# 有主电磁炮放电：只朝"不是召唤者"的人放电（召唤者站在炮口前也不会被劈）
scoreboard players set @s kitpvp.sparky_charge 0
playsound minecraft:entity.lightning_bolt.thunder master @a[distance=..32] ~ ~ ~ 1.0 1.2
execute if entity @p[distance=..12,gamemode=!spectator,tag=!kitpvp.spectator,nbt=!{Health:0.0f}] unless score @p[distance=..12,sort=nearest] kitpvp.etid = #spk_owner kitpvp.game at @p[distance=..12,gamemode=!spectator,tag=!kitpvp.spectator,nbt=!{Health:0.0f}] run function kitpvp:skill/earth/sparky_burst
