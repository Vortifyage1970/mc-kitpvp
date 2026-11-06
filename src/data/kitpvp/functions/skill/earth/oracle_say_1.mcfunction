# 第 1 句：场上还剩下 X 人
scoreboard players set #oracle_n kitpvp.game 0
execute as @a[gamemode=!spectator,tag=!kitpvp.spectator,nbt=!{Health:0.0f}] run scoreboard players add #oracle_n kitpvp.game 1
tellraw @a [{"text":"[预言家] ","color":"light_purple","bold":true},{"text":"场上还剩下 ","color":"white"},{"score":{"name":"#oracle_n","objective":"kitpvp.game"},"color":"gold"},{"text":" 人","color":"white"}]
