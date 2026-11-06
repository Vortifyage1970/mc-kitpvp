# @s = 变色者：每 5 秒换一次头顶方块，六种等概率（3 位随机 = 0..7，再对 6 取模）
scoreboard players set @s kitpvp.earth_cd_a 100
scoreboard players set @s kitpvp.rng 0
execute if predicate kitpvp:random/1in2 run scoreboard players add @s kitpvp.rng 1
execute if predicate kitpvp:random/1in2 run scoreboard players add @s kitpvp.rng 2
execute if predicate kitpvp:random/1in2 run scoreboard players add @s kitpvp.rng 4
scoreboard players operation @s kitpvp.rng %= #six kitpvp.game

# 先摘掉旧的（空气），再放新的：避免某些方块 id 之间的 item replace 合并成堆叠
item replace entity @s armor.head with minecraft:air
execute if score @s kitpvp.rng matches 0 run item replace entity @s armor.head with minecraft:grass_block
execute if score @s kitpvp.rng matches 1 run item replace entity @s armor.head with minecraft:podzol
execute if score @s kitpvp.rng matches 2 run item replace entity @s armor.head with minecraft:mycelium
execute if score @s kitpvp.rng matches 3 run item replace entity @s armor.head with minecraft:dirt_path
execute if score @s kitpvp.rng matches 4 run item replace entity @s armor.head with minecraft:coarse_dirt
execute if score @s kitpvp.rng matches 5 run item replace entity @s armor.head with minecraft:farmland
