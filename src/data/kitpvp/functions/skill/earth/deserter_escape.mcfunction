# 地球·81 逃兵：跑出 16 格 = 跑掉了。先挪到世界底下再 kill，地面上看不到死亡动画和音效
playsound minecraft:entity.ender_eye.launch neutral @a[distance=..16] ~ ~ ~ 0.8 1.5
particle minecraft:poof ~ ~1 ~ 0.6 0.8 0.6 0.05 24 normal
kill @e[tag=kitpvp.dser_wolf]
tp @s ~ -100 ~
kill @s
