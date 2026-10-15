# 前摇结束：报第三句 → 落水球 → 进冷却。

tellraw @a [{"text":"✦　","color":"dark_aqua"},{"text":"术式顺转","color":"white","bold":true},{"text":" · ","color":"dark_gray"},{"text":"「苍」","color":"aqua","bold":true},{"text":"　✦","color":"dark_aqua"}]
execute as @a at @s run playsound minecraft:item.trident.thunder master @s ~ ~ ~ 0.7 1.2

# 球心 = 10 格内最近的一名玩家（不含自己）；一个都没有就以自己为中心。
# 选择器里比不了身份，用同刻自清的临时 tag 把自己摘出去（同狼人的嗅闻）
tag @s add kitpvp.tainted_fisher_self
execute if entity @a[tag=kitpvp.selected,tag=!kitpvp.spectator,tag=!kitpvp.tainted_fisher_self,scores={kitpvp.alive=1},distance=..10] at @a[tag=kitpvp.selected,tag=!kitpvp.spectator,tag=!kitpvp.tainted_fisher_self,scores={kitpvp.alive=1},distance=..10,sort=nearest,limit=1] run function kitpvp:skill/tainted_fisher/blue_ball
execute unless entity @a[tag=kitpvp.selected,tag=!kitpvp.spectator,tag=!kitpvp.tainted_fisher_self,scores={kitpvp.alive=1},distance=..10] at @s run function kitpvp:skill/tainted_fisher/blue_ball
tag @s remove kitpvp.tainted_fisher_self

tag @s remove kitpvp.tainted_fisher_cang
scoreboard players set @s kitpvp.tainted_fisher_cang_timer 0
scoreboard players set @s kitpvp.cd 1200
scoreboard players set @s kitpvp.cd2 1200
# 令牌发回窗口在 blue_cast 就开好了；这里只置真冷却（窗口要等整把锁走完才发回）
title @s actionbar {"text":"术式顺转·「苍」：两个技能各冷却 60 秒","color":"aqua"}
