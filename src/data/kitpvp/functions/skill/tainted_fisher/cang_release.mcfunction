# 报第三句 → 落水球 → 置冷却。

tellraw @a [{"text":"✦　","color":"dark_aqua"},{"text":"术式顺转","color":"white","bold":true},{"text":" · ","color":"dark_gray"},{"text":"「苍」","color":"aqua","bold":true},{"text":"　✦","color":"dark_aqua"}]
execute as @a at @s run playsound minecraft:item.trident.thunder master @s ~ ~ ~ 0.7 1.2

# 球心 = 10 格内最近的玩家（不含自己），无人则取自己；用同刻自清的 tag 把自己摘出去
tag @s add kitpvp.tainted_fisher_self
execute if entity @a[tag=kitpvp.selected,tag=!kitpvp.spectator,tag=!kitpvp.tainted_fisher_self,scores={kitpvp.alive=1},distance=..10] at @a[tag=kitpvp.selected,tag=!kitpvp.spectator,tag=!kitpvp.tainted_fisher_self,scores={kitpvp.alive=1},distance=..10,sort=nearest,limit=1] run function kitpvp:skill/tainted_fisher/blue_ball
execute unless entity @a[tag=kitpvp.selected,tag=!kitpvp.spectator,tag=!kitpvp.tainted_fisher_self,scores={kitpvp.alive=1},distance=..10] at @s run function kitpvp:skill/tainted_fisher/blue_ball
tag @s remove kitpvp.tainted_fisher_self

tag @s remove kitpvp.tainted_fisher_cang
scoreboard players set @s kitpvp.tainted_fisher_cang_timer 0
scoreboard players set @s kitpvp.cd 900
scoreboard players set @s kitpvp.cd2 900
title @s actionbar {"text":"术式顺转·「苍」：冷却 45 秒","color":"aqua"}
