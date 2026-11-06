# @s = 篝火：刚被打了（HurtTime ≥ 1）且当前处于"待点火"（fire_left ≤ 0）⇒ 点着 5 秒
scoreboard players set @s kitpvp.fire_left 100
data merge entity @s {Fire:100s}
playsound minecraft:item.firecharge.use master @a[distance=..24] ~ ~ ~ 1.0 1.1
playsound minecraft:block.fire.ambient master @a[distance=..24] ~ ~ ~ 0.8 1.0
particle minecraft:flame ~ ~1 ~ 0.6 0.8 0.6 0.02 30
particle minecraft:smoke ~ ~1.2 ~ 0.6 0.8 0.6 0.01 12
