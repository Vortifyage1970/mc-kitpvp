# @s = 保洁员：每 15 秒扫一次地，8 格内的掉落物 + 载具（矿车/船）全部消失
scoreboard players set @s kitpvp.earth_cd_a 300

# —— 掉落物按"件"数，不按"堆"数：一堆 64 个木头算 64 件（上一版只报堆数，丢 3 个牛排=1 堆，所以显示"1"）
scoreboard players set #jan kitpvp.game 0
execute at @s as @e[type=minecraft:item,distance=..8] store result score @s kitpvp.jan_unit run data get entity @s Item.Count 1
execute at @s as @e[type=minecraft:item,distance=..8] run scoreboard players operation #jan kitpvp.game += @s kitpvp.jan_unit

# —— 载具另算：矿车六种 + 船两种（boat 含竹筏，chest_boat 就是运输船/运输竹筏）
scoreboard players set #jan_v kitpvp.game 0
execute at @s as @e[type=minecraft:minecart,distance=..8] run scoreboard players add #jan_v kitpvp.game 1
execute at @s as @e[type=minecraft:chest_minecart,distance=..8] run scoreboard players add #jan_v kitpvp.game 1
execute at @s as @e[type=minecraft:furnace_minecart,distance=..8] run scoreboard players add #jan_v kitpvp.game 1
execute at @s as @e[type=minecraft:hopper_minecart,distance=..8] run scoreboard players add #jan_v kitpvp.game 1
execute at @s as @e[type=minecraft:tnt_minecart,distance=..8] run scoreboard players add #jan_v kitpvp.game 1
execute at @s as @e[type=minecraft:command_block_minecart,distance=..8] run scoreboard players add #jan_v kitpvp.game 1
execute at @s as @e[type=minecraft:boat,distance=..8] run scoreboard players add #jan_v kitpvp.game 1
execute at @s as @e[type=minecraft:chest_boat,distance=..8] run scoreboard players add #jan_v kitpvp.game 1
execute at @s as @e[type=minecraft:chest_raft,distance=..8] run scoreboard players add #jan_v kitpvp.game 1

# —— 播报（0 件 0 载具就完全不吭声）
execute if score #jan kitpvp.game matches 1.. run tellraw @a [{"text":"[保洁员]","color":"white","bold":true},{"text":" 收走了 ","color":"gray"},{"score":{"name":"#jan","objective":"kitpvp.game"},"color":"yellow"},{"text":" 件掉落物。","color":"gray"}]
execute if score #jan_v kitpvp.game matches 1.. run tellraw @a [{"text":"[保洁员]","color":"white","bold":true},{"text":" 拖走了 ","color":"gray"},{"score":{"name":"#jan_v","objective":"kitpvp.game"},"color":"gold"},{"text":" 个载具。","color":"gray"}]
execute if score #jan kitpvp.game matches 1.. at @s run playsound minecraft:entity.item.pickup master @a[distance=..24] ~ ~ ~ 1.0 1.0
execute if score #jan_v kitpvp.game matches 1.. at @s run playsound minecraft:block.piston.contract master @a[distance=..24] ~ ~ ~ 0.9 0.8
execute if score #jan kitpvp.game matches 1.. at @s run particle minecraft:poof ~ ~ ~ 4 1 4 0.1 20

# —— 清场：和计数用同一批选择器，保证"报几件就清几件"
execute at @s run kill @e[type=minecraft:item,distance=..8]
execute at @s run kill @e[type=minecraft:minecart,distance=..8]
execute at @s run kill @e[type=minecraft:chest_minecart,distance=..8]
execute at @s run kill @e[type=minecraft:furnace_minecart,distance=..8]
execute at @s run kill @e[type=minecraft:hopper_minecart,distance=..8]
execute at @s run kill @e[type=minecraft:tnt_minecart,distance=..8]
execute at @s run kill @e[type=minecraft:command_block_minecart,distance=..8]
execute at @s run kill @e[type=minecraft:boat,distance=..8]
execute at @s run kill @e[type=minecraft:chest_boat,distance=..8]
execute at @s run kill @e[type=minecraft:chest_raft,distance=..8]
