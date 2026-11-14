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
# 里·末影人本来就有一把传送枪，别再把末影人魂石发给他（抽到 15 就顺延成 0）
execute if score @s kitpvp.kit matches 33 if score @s kitpvp.soul_rand matches 15 run scoreboard players set @s kitpvp.soul_rand 0

execute if score @s kitpvp.soul_rand matches 0 run give @s minecraft:blaze_spawn_egg{KitSoul:1b,KitSoulWarrior:1b,display:{Name:'{"text":"战士魂石","color":"red"}'}} 1
execute if score @s kitpvp.soul_rand matches 1 run give @s minecraft:skeleton_spawn_egg{KitSoul:1b,KitSoulArcher:1b,display:{Name:'{"text":"弓箭手魂石","color":"green"}'}} 1
execute if score @s kitpvp.soul_rand matches 2 run give @s minecraft:iron_golem_spawn_egg{KitSoul:1b,KitSoulTank:1b,display:{Name:'{"text":"坦克魂石","color":"aqua"}'}} 1
execute if score @s kitpvp.soul_rand matches 3 run give @s minecraft:enderman_spawn_egg{KitSoul:1b,KitSoulAssassin:1b,display:{Name:'{"text":"刺客魂石","color":"dark_purple"}'}} 1
execute if score @s kitpvp.soul_rand matches 4 run give @s minecraft:vex_spawn_egg{KitSoul:1b,KitSoulGhost:1b,display:{Name:'{"text":"幽灵魂石","color":"dark_aqua"}'}} 1
execute if score @s kitpvp.soul_rand matches 5 run give @s minecraft:pillager_spawn_egg{KitSoul:1b,KitSoulPirate:1b,display:{Name:'{"text":"海盗魂石","color":"dark_blue"}'}} 1
execute if score @s kitpvp.soul_rand matches 6 run give @s minecraft:cod_spawn_egg{KitSoul:1b,KitSoulFisher:1b,EntityTag:{Tags:["kitpvp.soul_fisher_token"]},display:{Name:'{"text":"渔夫魂石","color":"blue"}'}} 1
execute if score @s kitpvp.soul_rand matches 7 run give @s minecraft:husk_spawn_egg{KitSoul:1b,KitSoulZombie:1b,display:{Name:'{"text":"僵尸魂石","color":"dark_green"}'}} 1
execute if score @s kitpvp.soul_rand matches 8 run give @s minecraft:villager_spawn_egg{KitSoul:1b,KitSoulEarth:1b,display:{Name:'{"text":"地球魂石","color":"blue"}'}} 1
execute if score @s kitpvp.soul_rand matches 9 run give @s minecraft:pig_spawn_egg{KitSoul:1b,KitSoulLi:1b,display:{Name:'{"text":"李朱俊泽魂石","color":"light_purple"}'}} 1
execute if score @s kitpvp.soul_rand matches 10 run give @s minecraft:cat_spawn_egg{KitSoul:1b,KitSoulTamer:1b,EntityTag:{Tags:["kitpvp.soul_tamer_token"]},display:{Name:'{"text":"驯兽师魂石","color":"green"}'}} 1
execute if score @s kitpvp.soul_rand matches 11 run give @s minecraft:allay_spawn_egg{KitSoul:1b,KitSoulSun:1b,EntityTag:{Tags:["kitpvp.soul_sun_token"]},display:{Name:'{"text":"太阳魂石","color":"gold"}'}} 1
execute if score @s kitpvp.soul_rand matches 12 run give @s minecraft:tropical_fish_spawn_egg{KitSoul:1b,KitSoulMercury:1b,EntityTag:{Tags:["kitpvp.soul_mercury_token"]},display:{Name:'{"text":"水星魂石","color":"aqua"}'}} 1
execute if score @s kitpvp.soul_rand matches 13 run give @s minecraft:ocelot_spawn_egg{KitSoul:1b,KitSoulVenus:1b,EntityTag:{Tags:["kitpvp.soul_venus_token"]},display:{Name:'{"text":"金星魂石","color":"gold"}'}} 1
execute if score @s kitpvp.soul_rand matches 15 run give @s minecraft:endermite_spawn_egg{KitSoul:1b,KitSoulEnderman:1b,EntityTag:{Tags:["kitpvp.soul_ep_token"]},display:{Name:'{"text":"末影人魂石","color":"dark_purple"}'}} 1
execute if score @s kitpvp.soul_rand matches 14 run give @s minecraft:slime_spawn_egg{KitSoul:1b,KitSoulSlime:1b,EntityTag:{Size:0,Tags:["kitpvp.soul_slime_token"]},display:{Name:'{"text":"史莱姆魂石","color":"green"}'}} 1
