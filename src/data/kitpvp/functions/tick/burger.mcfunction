# 汉堡小子：每刻蓄力 + 每人独立 bossbar 进度（只有自己看）
execute as @a[tag=kitpvp.selected,scores={kitpvp.alive=1,kitpvp.kit=89},tag=!kitpvp.spectator] at @s run function kitpvp:skill/burger/charge
execute as @a[scores={kitpvp.kit=89,kitpvp.burger_slot=1}] run bossbar set kitpvp:burger_hud_1 players @s
execute as @a[scores={kitpvp.kit=89,kitpvp.burger_slot=1}] run execute store result bossbar kitpvp:burger_hud_1 value run scoreboard players get @s kitpvp.burger_charge
execute as @a[scores={kitpvp.kit=89,kitpvp.burger_slot=2}] run bossbar set kitpvp:burger_hud_2 players @s
execute as @a[scores={kitpvp.kit=89,kitpvp.burger_slot=2}] run execute store result bossbar kitpvp:burger_hud_2 value run scoreboard players get @s kitpvp.burger_charge
execute as @a[scores={kitpvp.kit=89,kitpvp.burger_slot=3}] run bossbar set kitpvp:burger_hud_3 players @s
execute as @a[scores={kitpvp.kit=89,kitpvp.burger_slot=3}] run execute store result bossbar kitpvp:burger_hud_3 value run scoreboard players get @s kitpvp.burger_charge
execute as @a[scores={kitpvp.kit=89,kitpvp.burger_slot=4}] run bossbar set kitpvp:burger_hud_4 players @s
execute as @a[scores={kitpvp.kit=89,kitpvp.burger_slot=4}] run execute store result bossbar kitpvp:burger_hud_4 value run scoreboard players get @s kitpvp.burger_charge
execute as @a[scores={kitpvp.kit=89,kitpvp.burger_slot=5}] run bossbar set kitpvp:burger_hud_5 players @s
execute as @a[scores={kitpvp.kit=89,kitpvp.burger_slot=5}] run execute store result bossbar kitpvp:burger_hud_5 value run scoreboard players get @s kitpvp.burger_charge
execute as @a[scores={kitpvp.kit=89,kitpvp.burger_slot=6}] run bossbar set kitpvp:burger_hud_6 players @s
execute as @a[scores={kitpvp.kit=89,kitpvp.burger_slot=6}] run execute store result bossbar kitpvp:burger_hud_6 value run scoreboard players get @s kitpvp.burger_charge
execute as @a[scores={kitpvp.kit=89,kitpvp.burger_slot=7}] run bossbar set kitpvp:burger_hud_7 players @s
execute as @a[scores={kitpvp.kit=89,kitpvp.burger_slot=7}] run execute store result bossbar kitpvp:burger_hud_7 value run scoreboard players get @s kitpvp.burger_charge
execute as @a[scores={kitpvp.kit=89,kitpvp.burger_slot=8}] run bossbar set kitpvp:burger_hud_8 players @s
execute as @a[scores={kitpvp.kit=89,kitpvp.burger_slot=8}] run execute store result bossbar kitpvp:burger_hud_8 value run scoreboard players get @s kitpvp.burger_charge
