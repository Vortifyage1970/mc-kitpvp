# @s = 使用者；执行位置/朝向 = 被攻击者（由上层 execute at @s as @a[...] 保留）
# ⚠ 本函数内不能再调 at @s，否则阴兵会出现在使用者身边而不是被攻击者身边
execute positioned ^1 ^ ^ run function kitpvp:summon/ghost_minion
execute positioned ^-1 ^ ^ run function kitpvp:summon/ghost_minion

execute if score @s kitpvp.tid matches 0 run scoreboard players add #ghost_tid kitpvp.game 1
execute if score @s kitpvp.tid matches 0 if score #ghost_tid kitpvp.game matches 7.. run scoreboard players set #ghost_tid kitpvp.game 1
execute if score @s kitpvp.tid matches 0 run scoreboard players operation @s kitpvp.tid = #ghost_tid kitpvp.game

execute if score @s kitpvp.tid matches 1 run team join ghost_1 @s
execute if score @s kitpvp.tid matches 2 run team join ghost_2 @s
execute if score @s kitpvp.tid matches 3 run team join ghost_3 @s
execute if score @s kitpvp.tid matches 4 run team join ghost_4 @s
execute if score @s kitpvp.tid matches 5 run team join ghost_5 @s
execute if score @s kitpvp.tid matches 6 run team join ghost_6 @s

execute if score @s kitpvp.tid matches 1 run team join ghost_1 @e[tag=kitpvp.ghost_minion_new]
execute if score @s kitpvp.tid matches 2 run team join ghost_2 @e[tag=kitpvp.ghost_minion_new]
execute if score @s kitpvp.tid matches 3 run team join ghost_3 @e[tag=kitpvp.ghost_minion_new]
execute if score @s kitpvp.tid matches 4 run team join ghost_4 @e[tag=kitpvp.ghost_minion_new]
execute if score @s kitpvp.tid matches 5 run team join ghost_5 @e[tag=kitpvp.ghost_minion_new]
execute if score @s kitpvp.tid matches 6 run team join ghost_6 @e[tag=kitpvp.ghost_minion_new]

tag @e remove kitpvp.ghost_minion_new

# 5 秒召唤冷却
scoreboard players set @s kitpvp.ghost_minion_cd 100

execute as @s run playsound minecraft:entity.warden.attack_impact master @a[distance=..9] ~ ~ ~ 0.8 1.2

title @s actionbar {"text":"阴兵已现（20 秒）","color":"dark_aqua"}
