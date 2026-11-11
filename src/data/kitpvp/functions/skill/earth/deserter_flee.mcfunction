# 地球·81 逃兵：半血触发一次 —— 进入"恐惧"状态：关掉 AI（不再寻路/攻击），交给 deserter_run 每刻背对着跑
# ★ 恐惧不是原版药水（1.20.1 没有），用三样东西凑：一声惊叫 + 灰白烟 + 每刻更快地背对逃跑（见 deserter_run）
tag @s add kitpvp.dser_flee
data merge entity @s {NoAI:1b}
playsound minecraft:entity.villager.hurt hostile @a[distance=..12] ~ ~ ~ 1.0 1.3
playsound minecraft:entity.rabbit.jump hostile @a[distance=..12] ~ ~ ~ 0.6 0.8
playsound minecraft:entity.phantom.swoop hostile @a[distance=..12] ~ ~ ~ 0.5 1.4
particle minecraft:poof ~ ~1 ~ 0.4 0.4 0.4 0.02 12 normal
particle minecraft:smoke ~ ~0.8 ~ 0.4 0.5 0.4 0.02 14 normal
