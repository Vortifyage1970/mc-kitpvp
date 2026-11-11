# 地球·81 逃兵：进入"怕狼"状态后，每刻把那只看不见的狼顶在它和最近的敌人之间，
# 原版骷髅的躲狼寻路就会一直把它往"背对追兵"的方向带 —— 我们不 tp 逃兵，只 tp 狼。
execute at @s facing entity @p[distance=..24,gamemode=!creative,gamemode=!spectator,tag=!kitpvp.spectator,nbt=!{Health:0.0f}] feet run tp @e[tag=kitpvp.dser_wolf,limit=1] ^ ^ ^0.9
# 最近的敌人超过 16 格 = 跑掉了
execute at @s unless entity @p[distance=..16,gamemode=!creative,gamemode=!spectator,tag=!kitpvp.spectator,nbt=!{Health:0.0f}] run function kitpvp:skill/earth/deserter_escape
# 被吓到的痕迹：脚下一串灰白烟
particle minecraft:poof ~ ~0.4 ~ 0.15 0.1 0.15 0.01 2 normal
