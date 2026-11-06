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


# 换头时叫一声：再掷 3 位（0..7 正好 8 种，不需要取模），随机换一种动物叫声 —— 又显眼又好定位（音量 2.0 > 1 会把可听半径撑到约 48 格）
scoreboard players set @s kitpvp.rng 0
execute if predicate kitpvp:random/1in2 run scoreboard players add @s kitpvp.rng 1
execute if predicate kitpvp:random/1in2 run scoreboard players add @s kitpvp.rng 2
execute if predicate kitpvp:random/1in2 run scoreboard players add @s kitpvp.rng 4
execute if score @s kitpvp.rng matches 0 at @s run playsound minecraft:entity.cat.ambient master @a[distance=..24] ~ ~ ~ 2.0 1.2
execute if score @s kitpvp.rng matches 1 at @s run playsound minecraft:entity.sheep.ambient master @a[distance=..24] ~ ~ ~ 2.0 1.0
execute if score @s kitpvp.rng matches 2 at @s run playsound minecraft:entity.cow.ambient master @a[distance=..24] ~ ~ ~ 2.0 1.1
execute if score @s kitpvp.rng matches 3 at @s run playsound minecraft:entity.chicken.ambient master @a[distance=..24] ~ ~ ~ 2.0 1.15
execute if score @s kitpvp.rng matches 4 at @s run playsound minecraft:entity.fox.ambient master @a[distance=..24] ~ ~ ~ 2.0 1.0
execute if score @s kitpvp.rng matches 5 at @s run playsound minecraft:entity.wolf.howl master @a[distance=..24] ~ ~ ~ 2.0 1.05
execute if score @s kitpvp.rng matches 6 at @s run playsound minecraft:entity.goat.screaming.ambient master @a[distance=..24] ~ ~ ~ 2.0 0.95
execute if score @s kitpvp.rng matches 7 at @s run playsound minecraft:entity.parrot.ambient master @a[distance=..24] ~ ~ ~ 2.0 1.4
