# @s = 火球：没打到人（撞方块或超时）就地熄灭，只留烟和火星，不动方块
particle minecraft:smoke ~ ~ ~ 0.2 0.2 0.2 0.02 8
particle minecraft:flame ~ ~ ~ 0.15 0.15 0.15 0.02 6
playsound minecraft:block.fire.extinguish neutral @a[distance=..12] ~ ~ ~ 0.6 1.4
kill @s
