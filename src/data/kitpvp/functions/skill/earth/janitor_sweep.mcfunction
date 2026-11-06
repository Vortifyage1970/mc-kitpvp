# @s = 保洁员：每 15 秒扫一次地，8 格内的掉落物全部消失
scoreboard players set @s kitpvp.earth_cd_a 300
# 先数一下扫到几件，0 件就不吵人
scoreboard players set #jan kitpvp.game 0
execute store result score #jan kitpvp.game if entity @e[type=minecraft:item,distance=..8]
execute if score #jan kitpvp.game matches 1.. run tellraw @a [{"text":"[保洁员]","color":"white","bold":true},{"text":" 收走了 ","color":"gray"},{"score":{"name":"#jan","objective":"kitpvp.game"},"color":"yellow"},{"text":" 件掉落物。","color":"gray"}]
execute if score #jan kitpvp.game matches 1.. at @s run playsound minecraft:entity.item.pickup master @a[distance=..24] ~ ~ ~ 1.0 0.7
execute if score #jan kitpvp.game matches 1.. at @s run particle minecraft:poof ~ ~ ~ 4 1 4 0.1 20
execute at @s run kill @e[type=minecraft:item,distance=..8]
