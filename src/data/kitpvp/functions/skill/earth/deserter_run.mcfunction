# 地球·81 逃兵：每刻背对最近的敌人、朝正前方跑 0.35 格（约 7 格/秒，比冲刺快一点）
# ★ 不再"回头看"：朝向用 tp 的 ~ 180 直接翻过去，背对着追兵往前跑
# 24 格内没有敌人就原地不动；一旦最近的敌人也超过 16 格，就当它跑掉了
execute at @s facing entity @p[distance=..24,gamemode=!creative,gamemode=!spectator,tag=!kitpvp.spectator,nbt=!{Health:0.0f}] feet run tp @s ^ ^ ^-0.35 ~ 180
execute at @s unless entity @p[distance=..16,gamemode=!creative,gamemode=!spectator,tag=!kitpvp.spectator,nbt=!{Health:0.0f}] run function kitpvp:skill/earth/deserter_escape
# 恐惧的痕迹：脚下一串灰白烟，被吓到地跑
particle minecraft:smoke ~ ~0.6 ~ 0.25 0.35 0.25 0.01 4 normal
particle minecraft:poof ~ ~0.4 ~ 0.15 0.1 0.15 0.01 2 normal
