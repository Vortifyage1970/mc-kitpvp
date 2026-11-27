# 太阳魂石（@s = 使用者本人，位置 = 使用者）
# 施放瞬间锁定：10 格内**除使用者以外**的参战玩家，每人一次性 20 秒失明
# 之后标记留在人身上（不是留在地上）：这 20 秒里即使跑出范围，也会继续被噪音干扰
#
# ⚠ 不要用"离令牌最近的玩家"来猜施法者：令牌是**悦灵**，会自己飞走，
#   飞远/飞偏后一个玩家都匹配不到，施法者就不会被排除 → 把自己也罩进失明（2026-11-28 实机 bug）。
#   整条链 use_sun → sun_at → sun_apply 上 @s 始终就是使用者，直接用即可。
execute if entity @s[type=minecraft:player] run tag @s add kitpvp.soul_sun_owner
execute at @s as @a[distance=..10,scores={kitpvp.alive=1},tag=!kitpvp.spectator,tag=!kitpvp.soul_sun_owner] run function kitpvp:skill/soul/sun_mark
execute if entity @s[type=minecraft:player] run tag @s remove kitpvp.soul_sun_owner

title @s actionbar {"text":"魂石·日蚀：10 格内其他人失明 20 秒，噪音会一直跟着他们","color":"gold"}
playsound minecraft:block.beacon.deactivate master @s ~ ~ ~ 1.0 0.6
