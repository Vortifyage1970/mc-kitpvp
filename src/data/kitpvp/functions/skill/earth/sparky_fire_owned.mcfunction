# 有主电磁炮放电：只朝"不是召唤者"的人放电（召唤者站在炮口前也不会被劈）
# 命中后 sparky_burst 会再排除一次召唤者：站在爆炸半径里的自己人也不吃这 8 点
scoreboard players set @s kitpvp.sparky_charge 0
playsound minecraft:entity.lightning_bolt.thunder master @a[distance=..40] ~ ~ ~ 1.0 1.2
execute if entity @p[distance=..15,gamemode=!spectator,tag=!kitpvp.spectator,nbt=!{Health:0.0f}] unless score @p[distance=..15,sort=nearest] kitpvp.etid = #spk_owner kitpvp.game at @p[distance=..15,gamemode=!spectator,tag=!kitpvp.spectator,nbt=!{Health:0.0f}] run function kitpvp:skill/earth/sparky_burst
