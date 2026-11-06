# 保洁员件数自检：站在掉落物旁边跑 /function kitpvp:debug/janitor_count
# 会并排打出"遍历计数"和"store result 计数"，再打出清完之后还剩几件
scoreboard players set #jan_iter kitpvp.game 0
execute as @e[type=minecraft:item,distance=..8] at @s run scoreboard players add #jan_iter kitpvp.game 1
scoreboard players set #jan_store kitpvp.game 0
execute store result score #jan_store kitpvp.game if entity @e[type=minecraft:item,distance=..8]
tellraw @a [{"text":"[保洁员自检]","color":"white","bold":true},{"text":" 遍历计数 = ","color":"gray"},{"score":{"name":"#jan_iter","objective":"kitpvp.game"},"color":"yellow"},{"text":" ；store result = ","color":"gray"},{"score":{"name":"#jan_store","objective":"kitpvp.game"},"color":"aqua"}]
execute at @s run kill @e[type=minecraft:item,distance=..8]
scoreboard players set #jan_left kitpvp.game 0
execute store result score #jan_left kitpvp.game if entity @e[type=minecraft:item,distance=..8]
tellraw @a [{"text":"[保洁员自检]","color":"white","bold":true},{"text":" 清完还剩 = ","color":"gray"},{"score":{"name":"#jan_left","objective":"kitpvp.game"},"color":"red"}]
