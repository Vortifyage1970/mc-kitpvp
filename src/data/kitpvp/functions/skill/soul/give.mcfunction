# 位随机（1in2 连掷 10 次 → 0..1023）再对 #soul_count 取模；新增魂石 = 追加 1 行 give + #soul_count +1
# display.Name 会成为生成生物的 CustomName（已实测），坦克/刺客魂石靠它与令牌分流
scoreboard players set @s kitpvp.soul_rand 0
execute if predicate kitpvp:random/1in2 run scoreboard players add @s kitpvp.soul_rand 1
execute if predicate kitpvp:random/1in2 run scoreboard players add @s kitpvp.soul_rand 2
execute if predicate kitpvp:random/1in2 run scoreboard players add @s kitpvp.soul_rand 4
execute if predicate kitpvp:random/1in2 run scoreboard players add @s kitpvp.soul_rand 8
execute if predicate kitpvp:random/1in2 run scoreboard players add @s kitpvp.soul_rand 16
execute if predicate kitpvp:random/1in2 run scoreboard players add @s kitpvp.soul_rand 32
execute if predicate kitpvp:random/1in2 run scoreboard players add @s kitpvp.soul_rand 64
execute if predicate kitpvp:random/1in2 run scoreboard players add @s kitpvp.soul_rand 128
execute if predicate kitpvp:random/1in2 run scoreboard players add @s kitpvp.soul_rand 256
execute if predicate kitpvp:random/1in2 run scoreboard players add @s kitpvp.soul_rand 512

scoreboard players operation @s kitpvp.soul_rand %= #soul_count kitpvp.game

execute if score @s kitpvp.soul_rand matches 0 run give @s minecraft:blaze_spawn_egg{KitSoul:1b,KitSoulWarrior:1b,display:{Name:'{"text":"战士魂石","color":"red","bold":true}'}} 1
execute if score @s kitpvp.soul_rand matches 1 run give @s minecraft:skeleton_spawn_egg{KitSoul:1b,KitSoulArcher:1b,display:{Name:'{"text":"弓箭手魂石","color":"green","bold":true}'}} 1
execute if score @s kitpvp.soul_rand matches 2 run give @s minecraft:iron_golem_spawn_egg{KitSoul:1b,KitSoulTank:1b,display:{Name:'{"text":"坦克魂石","color":"aqua","bold":true}'}} 1
execute if score @s kitpvp.soul_rand matches 3 run give @s minecraft:enderman_spawn_egg{KitSoul:1b,KitSoulAssassin:1b,display:{Name:'{"text":"刺客魂石","color":"dark_purple","bold":true}'}} 1
execute if score @s kitpvp.soul_rand matches 4 run give @s minecraft:vex_spawn_egg{KitSoul:1b,KitSoulGhost:1b,display:{Name:'{"text":"幽灵魂石","color":"dark_aqua","bold":true}'}} 1
