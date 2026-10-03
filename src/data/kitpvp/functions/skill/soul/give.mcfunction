# ===== 魂石：给一个玩家随机发一颗魂石蛋（@s = 单个玩家）=====
# 位随机（同一 1in2 谓词连掷 10 次得 0..1023）+ 对 #soul_count 取模。
# 加新魂石 = 追加 1 行 give + #soul_count +1，不需要新增谓词文件。
# 坦克/刺客魂石复用它们令牌的蛋类型，靠 display.Name 与令牌区分。
# display.Name 会成为生成生物的 CustomName（已实测），这就是分流的依据。

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