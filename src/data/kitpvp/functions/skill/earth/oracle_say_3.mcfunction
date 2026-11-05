# 第 3 句：剩余命数最多的是谁（先取最大值，再报分数等于最大值的人）
scoreboard players set #oracle_lives kitpvp.game 0
execute as @a[gamemode=!spectator,tag=!kitpvp.spectator,nbt=!{Health:0.0f},scores={kitpvp.lives=1..}] run scoreboard players operation #oracle_lives kitpvp.game > @s kitpvp.lives
execute as @a[gamemode=!spectator,tag=!kitpvp.spectator,nbt=!{Health:0.0f}] if score @s kitpvp.lives = #oracle_lives kitpvp.game run tellraw @a [{"text":"[预言家] ","color":"light_purple","bold":true},{"text":"剩余命数最多的是 ","color":"white"},{"selector":"@s","color":"green"},{"text":"（还剩 ","color":"white"},{"score":{"name":"@s","objective":"kitpvp.lives"},"color":"gold"},{"text":" 条命）","color":"white"}]
execute unless entity @a[gamemode=!spectator,tag=!kitpvp.spectator,nbt=!{Health:0.0f},scores={kitpvp.lives=1..}] run tellraw @a [{"text":"[预言家] ","color":"light_purple","bold":true},{"text":"我看不清谁的命还多","color":"gray"}]
