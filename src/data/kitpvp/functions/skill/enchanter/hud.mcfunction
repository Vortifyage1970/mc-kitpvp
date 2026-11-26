# 附魔师 HUD：像汉堡小子那样，每人一条 bossbar 显示距离下一发的蓄力进度
bossbar set kitpvp:ench_hud_1 players
bossbar set kitpvp:ench_hud_2 players
bossbar set kitpvp:ench_hud_3 players
bossbar set kitpvp:ench_hud_4 players
bossbar set kitpvp:ench_hud_5 players
bossbar set kitpvp:ench_hud_6 players
bossbar set kitpvp:ench_hud_7 players
bossbar set kitpvp:ench_hud_8 players
execute if score #state kitpvp.game matches 1 as @a[scores={kitpvp.kit=98,kitpvp.ench_slot=1}] run bossbar set kitpvp:ench_hud_1 players @s
execute if score #state kitpvp.game matches 1 as @a[scores={kitpvp.kit=98,kitpvp.ench_slot=2}] run bossbar set kitpvp:ench_hud_2 players @s
execute if score #state kitpvp.game matches 1 as @a[scores={kitpvp.kit=98,kitpvp.ench_slot=3}] run bossbar set kitpvp:ench_hud_3 players @s
execute if score #state kitpvp.game matches 1 as @a[scores={kitpvp.kit=98,kitpvp.ench_slot=4}] run bossbar set kitpvp:ench_hud_4 players @s
execute if score #state kitpvp.game matches 1 as @a[scores={kitpvp.kit=98,kitpvp.ench_slot=5}] run bossbar set kitpvp:ench_hud_5 players @s
execute if score #state kitpvp.game matches 1 as @a[scores={kitpvp.kit=98,kitpvp.ench_slot=6}] run bossbar set kitpvp:ench_hud_6 players @s
execute if score #state kitpvp.game matches 1 as @a[scores={kitpvp.kit=98,kitpvp.ench_slot=7}] run bossbar set kitpvp:ench_hud_7 players @s
execute if score #state kitpvp.game matches 1 as @a[scores={kitpvp.kit=98,kitpvp.ench_slot=8}] run bossbar set kitpvp:ench_hud_8 players @s
execute if score #state kitpvp.game matches 1 as @a[scores={kitpvp.kit=98,kitpvp.ench_slot=1}] run execute store result bossbar kitpvp:ench_hud_1 value run scoreboard players get @s kitpvp.ench_pct
execute if score #state kitpvp.game matches 1 as @a[scores={kitpvp.kit=98,kitpvp.ench_slot=2}] run execute store result bossbar kitpvp:ench_hud_2 value run scoreboard players get @s kitpvp.ench_pct
execute if score #state kitpvp.game matches 1 as @a[scores={kitpvp.kit=98,kitpvp.ench_slot=3}] run execute store result bossbar kitpvp:ench_hud_3 value run scoreboard players get @s kitpvp.ench_pct
execute if score #state kitpvp.game matches 1 as @a[scores={kitpvp.kit=98,kitpvp.ench_slot=4}] run execute store result bossbar kitpvp:ench_hud_4 value run scoreboard players get @s kitpvp.ench_pct
execute if score #state kitpvp.game matches 1 as @a[scores={kitpvp.kit=98,kitpvp.ench_slot=5}] run execute store result bossbar kitpvp:ench_hud_5 value run scoreboard players get @s kitpvp.ench_pct
execute if score #state kitpvp.game matches 1 as @a[scores={kitpvp.kit=98,kitpvp.ench_slot=6}] run execute store result bossbar kitpvp:ench_hud_6 value run scoreboard players get @s kitpvp.ench_pct
execute if score #state kitpvp.game matches 1 as @a[scores={kitpvp.kit=98,kitpvp.ench_slot=7}] run execute store result bossbar kitpvp:ench_hud_7 value run scoreboard players get @s kitpvp.ench_pct
execute if score #state kitpvp.game matches 1 as @a[scores={kitpvp.kit=98,kitpvp.ench_slot=8}] run execute store result bossbar kitpvp:ench_hud_8 value run scoreboard players get @s kitpvp.ench_pct
execute as @a[scores={kitpvp.kit=98,kitpvp.ench_slot=1,kitpvp.ench_roll=11}] run bossbar set kitpvp:ench_hud_1 color yellow
execute as @a[scores={kitpvp.kit=98,kitpvp.ench_slot=2,kitpvp.ench_roll=11}] run bossbar set kitpvp:ench_hud_2 color yellow
execute as @a[scores={kitpvp.kit=98,kitpvp.ench_slot=3,kitpvp.ench_roll=11}] run bossbar set kitpvp:ench_hud_3 color yellow
execute as @a[scores={kitpvp.kit=98,kitpvp.ench_slot=4,kitpvp.ench_roll=11}] run bossbar set kitpvp:ench_hud_4 color yellow
execute as @a[scores={kitpvp.kit=98,kitpvp.ench_slot=5,kitpvp.ench_roll=11}] run bossbar set kitpvp:ench_hud_5 color yellow
execute as @a[scores={kitpvp.kit=98,kitpvp.ench_slot=6,kitpvp.ench_roll=11}] run bossbar set kitpvp:ench_hud_6 color yellow
execute as @a[scores={kitpvp.kit=98,kitpvp.ench_slot=7,kitpvp.ench_roll=11}] run bossbar set kitpvp:ench_hud_7 color yellow
execute as @a[scores={kitpvp.kit=98,kitpvp.ench_slot=8,kitpvp.ench_roll=11}] run bossbar set kitpvp:ench_hud_8 color yellow
execute as @a[scores={kitpvp.kit=98,kitpvp.ench_slot=1}] unless score @s kitpvp.ench_roll matches 11 run bossbar set kitpvp:ench_hud_1 color blue
execute as @a[scores={kitpvp.kit=98,kitpvp.ench_slot=2}] unless score @s kitpvp.ench_roll matches 11 run bossbar set kitpvp:ench_hud_2 color blue
execute as @a[scores={kitpvp.kit=98,kitpvp.ench_slot=3}] unless score @s kitpvp.ench_roll matches 11 run bossbar set kitpvp:ench_hud_3 color blue
execute as @a[scores={kitpvp.kit=98,kitpvp.ench_slot=4}] unless score @s kitpvp.ench_roll matches 11 run bossbar set kitpvp:ench_hud_4 color blue
execute as @a[scores={kitpvp.kit=98,kitpvp.ench_slot=5}] unless score @s kitpvp.ench_roll matches 11 run bossbar set kitpvp:ench_hud_5 color blue
execute as @a[scores={kitpvp.kit=98,kitpvp.ench_slot=6}] unless score @s kitpvp.ench_roll matches 11 run bossbar set kitpvp:ench_hud_6 color blue
execute as @a[scores={kitpvp.kit=98,kitpvp.ench_slot=7}] unless score @s kitpvp.ench_roll matches 11 run bossbar set kitpvp:ench_hud_7 color blue
execute as @a[scores={kitpvp.kit=98,kitpvp.ench_slot=8}] unless score @s kitpvp.ench_roll matches 11 run bossbar set kitpvp:ench_hud_8 color blue
