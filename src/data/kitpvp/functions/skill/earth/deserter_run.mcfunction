# 地球·81 逃兵：每刻面朝最近的敌人、沿 -^ 倒退 0.3 格（背对着跑，看起来像一边回头看一边退）
# 24 格内没有敌人就原地不动；一旦最近的敌人也超过 16 格，就当它跑掉了
execute at @s facing entity @p[distance=..24,gamemode=!creative,gamemode=!spectator,tag=!kitpvp.spectator,nbt=!{Health:0.0f}] feet run tp @s ^ ^ ^-0.25
execute at @s unless entity @p[distance=..16,gamemode=!creative,gamemode=!spectator,tag=!kitpvp.spectator,nbt=!{Health:0.0f}] run function kitpvp:skill/earth/deserter_escape
particle minecraft:poof ~ ~0.4 ~ 0.15 0.1 0.15 0.01 2 normal
