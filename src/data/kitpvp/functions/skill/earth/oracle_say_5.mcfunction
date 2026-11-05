# 第 5 句：当前生命值最低的是谁（先取最小值，再把等于最小值的人报出来）
scoreboard players set #oracle_hpm kitpvp.game 2000000
execute as @a[gamemode=!spectator,tag=!kitpvp.spectator,nbt=!{Health:0.0f}] run scoreboard players operation #oracle_hpm kitpvp.game < @s kitpvp.hp_x10
execute as @a[gamemode=!spectator,tag=!kitpvp.spectator,nbt=!{Health:0.0f}] if score @s kitpvp.hp_x10 = #oracle_hpm kitpvp.game run tellraw @a [{"text":"[预言家] ","color":"light_purple","bold":true},{"text":"当前生命值最低的是 ","color":"white"},{"selector":"@s","color":"red"},{"text":"（","color":"white"},{"score":{"name":"@s","objective":"kitpvp.hp_x10"},"color":"gold"},{"text":" / 2000）","color":"white"}]
execute unless entity @a[gamemode=!spectator,tag=!kitpvp.spectator,nbt=!{Health:0.0f}] run tellraw @a [{"text":"[预言家] ","color":"light_purple","bold":true},{"text":"场上没有活人，没什么好说的","color":"gray"}]
