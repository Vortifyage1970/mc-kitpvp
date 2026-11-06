# @s = 保洁员：每 15 秒扫一次地，8 格内的掉落物全部消失
scoreboard players set @s kitpvp.earth_cd_a 300

# 件数用"遍历计数"，不要用 store result + if entity：后者在没有目标时不会写值，一旦哪天忘了先清零就会显示上一轮的数字
scoreboard players set #jan kitpvp.game 0
execute at @s as @e[type=minecraft:item,distance=..8] run scoreboard players add #jan kitpvp.game 1

# 0 件就完全不吭声
execute if score #jan kitpvp.game matches 1.. run tellraw @a [{"text":"[保洁员]","color":"white","bold":true},{"text":" 收走了 ","color":"gray"},{"score":{"name":"#jan","objective":"kitpvp.game"},"color":"yellow"},{"text":" 件掉落物。","color":"gray"}]
execute if score #jan kitpvp.game matches 1.. at @s run playsound minecraft:entity.item.pickup master @a[distance=..24] ~ ~ ~ 1.0 1.0
execute if score #jan kitpvp.game matches 1.. at @s run particle minecraft:poof ~ ~ ~ 4 1 4 0.1 20

# 清场：和计数用同一个选择器，保证"报几件就清几件"
execute at @s run kill @e[type=minecraft:item,distance=..8]
