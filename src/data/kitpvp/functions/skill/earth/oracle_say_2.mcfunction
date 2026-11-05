# 第 2 句：离我最近的玩家是谁（24 格内才报，不然说"四下无人"）
execute if entity @a[distance=..24,gamemode=!spectator,tag=!kitpvp.spectator,nbt=!{Health:0.0f}] run tellraw @a [{"text":"[预言家] ","color":"light_purple","bold":true},{"text":"离我最近的玩家是 ","color":"white"},{"selector":"@a[distance=..24,gamemode=!spectator,tag=!kitpvp.spectator,nbt=!{Health:0.0f},sort=nearest,limit=1]","color":"aqua"}]
execute unless entity @a[distance=..24,gamemode=!spectator,tag=!kitpvp.spectator,nbt=!{Health:0.0f}] run tellraw @a [{"text":"[预言家] ","color":"light_purple","bold":true},{"text":"四下无人，我什么都看不见","color":"gray"}]
