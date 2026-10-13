# 只做统计与判定，结算在 game/end。#test=1 时只统计不自动结算（防单人测试一开局就判胜）。
# 胜：仅剩 1 名幸存者。
# 平局：幸存者 0 且场上还有在线旁观者（仍有人看着，说明不是全员掉线）→ 走 end 的平局分支。
# 全员掉线（0 幸存者且无旁观者）不结算，避免误清场。
scoreboard players set #survivors kitpvp.game 0
execute as @a[tag=kitpvp.selected,tag=!kitpvp.spectator,gamemode=!spectator] run scoreboard players add #survivors kitpvp.game 1

execute if score #test kitpvp.game matches 0 if score #state kitpvp.game matches 1 if score #survivors kitpvp.game matches 1 run function kitpvp:game/end
execute if score #test kitpvp.game matches 0 if score #state kitpvp.game matches 1 if score #survivors kitpvp.game matches 0 if entity @a[tag=kitpvp.spectator] run function kitpvp:game/end
