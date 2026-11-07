# @s = 电磁炮：锁定 15 格内最近的活人，命中点半径 2.5 的结算在 sparky_burst
# 瞄准不排除主人 —— 单人测试时"最近的人"就是你，排除掉就永远没有目标；不砸自己人的事交给 burst
scoreboard players set @s kitpvp.sparky_charge 0
playsound minecraft:entity.lightning_bolt.thunder master @a[distance=..40] ~ ~ ~ 1.0 1.2
execute if entity @p[distance=..15,gamemode=!creative,gamemode=!spectator,tag=!kitpvp.spectator,nbt=!{Health:0.0f}] at @p[distance=..15,gamemode=!creative,gamemode=!spectator,tag=!kitpvp.spectator,nbt=!{Health:0.0f}] run function kitpvp:skill/earth/sparky_burst
