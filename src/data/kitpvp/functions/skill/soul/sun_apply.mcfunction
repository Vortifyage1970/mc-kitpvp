# 太阳魂石落地（执行位置 = 落点，@s = 使用者）
# 施放瞬间锁定：10 格内**除使用者以外**的参战玩家，每人一次性 20 秒失明
# 之后标记留在人身上（不是留在地上）：这 20 秒里即使跑出范围，也会继续被噪音干扰
# 使用者 = 落点最近的那名玩家，只在这次标记里用来排除，标完立刻摘掉
execute as @a[distance=..8,sort=nearest,limit=1] run tag @s add kitpvp.soul_sun_owner
execute at @s as @a[distance=..10,scores={kitpvp.alive=1},tag=!kitpvp.spectator,tag=!kitpvp.soul_sun_owner] run function kitpvp:skill/soul/sun_mark
tag @a remove kitpvp.soul_sun_owner

title @s actionbar {"text":"魂石·日蚀：10 格内其他人失明 20 秒，噪音会一直跟着他们","color":"gold"}
playsound minecraft:block.beacon.deactivate master @s ~ ~ ~ 1.0 0.6
