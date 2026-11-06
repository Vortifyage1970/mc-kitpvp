# @s = 篝火：这一帧火刚好烧完（fire_left 减到 0）⇒ 熄火，并把状态打回"待点火"（-1）
scoreboard players set @s kitpvp.fire_left -1
data merge entity @s {Fire:0s}
playsound minecraft:block.fire.extinguish master @a[distance=..24] ~ ~ ~ 0.9 0.9
particle minecraft:large_smoke ~ ~1 ~ 0.5 0.7 0.5 0.02 18
particle minecraft:smoke ~ ~0.8 ~ 0.5 0.6 0.5 0.01 10
