# 地球·81 逃兵：半血触发一次 —— 关掉 AI（不再寻路/攻击），交给 deserter_run 每刻往后挪
tag @s add kitpvp.dser_flee
data merge entity @s {NoAI:1b}
playsound minecraft:entity.villager.hurt hostile @a[distance=..12] ~ ~ ~ 1.0 1.3
playsound minecraft:entity.rabbit.jump hostile @a[distance=..12] ~ ~ ~ 0.6 0.8
particle minecraft:poof ~ ~1 ~ 0.4 0.4 0.4 0.02 12 normal
