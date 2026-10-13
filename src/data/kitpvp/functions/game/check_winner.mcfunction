# 只做统计与判定，真正的结算在 game/end。
# #test=1 时只统计不自动结算（防单人测试一开局就判胜）。
# 0 人不结算：避免全员掉线被误判平局并清场（设计文档第九节）。
scoreboard players set #survivors kitpvp.game 0
execute as @a[tag=kitpvp.selected,tag=!kitpvp.spectator,gamemode=!spectator] run scoreboard players add #survivors kitpvp.game 1

execute if score #test kitpvp.game matches 0 if score #state kitpvp.game matches 1 if score #survivors kitpvp.game matches 1 run function kitpvp:game/end
