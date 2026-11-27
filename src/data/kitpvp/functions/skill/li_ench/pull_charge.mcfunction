# 蓄力档：0.033 / 0.067 / 0.1 / 0.133 点，各 25%（原值 ÷15）
scoreboard players set #li_x kitpvp.game 0
execute store success score #li_b kitpvp.game if predicate kitpvp:random/1in2
execute if score #li_b kitpvp.game matches 1 run scoreboard players add #li_x kitpvp.game 1
execute store success score #li_b kitpvp.game if predicate kitpvp:random/1in2
execute if score #li_b kitpvp.game matches 1 run scoreboard players add #li_x kitpvp.game 2
execute if score #li_x kitpvp.game matches 0 run scoreboard players add @s kitpvp.ench_sw_fill 10
execute if score #li_x kitpvp.game matches 0 run scoreboard players add @s kitpvp.ench_ap_fill 10
execute if score #li_x kitpvp.game matches 0 run title @s actionbar [{"text":"◆ 蓄力 +0.03 点","color":"light_purple"},{"text":"（剑与甲）","color":"gray"}]
execute if score #li_x kitpvp.game matches 1 run scoreboard players add @s kitpvp.ench_sw_fill 20
execute if score #li_x kitpvp.game matches 1 run scoreboard players add @s kitpvp.ench_ap_fill 20
execute if score #li_x kitpvp.game matches 1 run title @s actionbar [{"text":"◆ 蓄力 +0.07 点","color":"light_purple"},{"text":"（剑与甲）","color":"gray"}]
execute if score #li_x kitpvp.game matches 2 run scoreboard players add @s kitpvp.ench_sw_fill 30
execute if score #li_x kitpvp.game matches 2 run scoreboard players add @s kitpvp.ench_ap_fill 30
execute if score #li_x kitpvp.game matches 2 run title @s actionbar [{"text":"◆ 蓄力 +0.1 点","color":"light_purple"},{"text":"（剑与甲）","color":"gray"}]
execute if score #li_x kitpvp.game matches 3 run scoreboard players add @s kitpvp.ench_sw_fill 40
execute if score #li_x kitpvp.game matches 3 run scoreboard players add @s kitpvp.ench_ap_fill 40
execute if score #li_x kitpvp.game matches 3 run title @s actionbar [{"text":"◆ 蓄力 +0.13 点","color":"light_purple"},{"text":"（剑与甲）","color":"gray"}]
execute if score @s kitpvp.ench_sw_fill matches 300.. run function kitpvp:skill/enchanter/fill_sw
execute if score @s kitpvp.ench_ap_fill matches 300.. run function kitpvp:skill/enchanter/fill_ap
execute if score @s kitpvp.ench_sw_fill matches 300.. run function kitpvp:skill/enchanter/fill_sw
execute if score @s kitpvp.ench_ap_fill matches 300.. run function kitpvp:skill/enchanter/fill_ap
function kitpvp:skill/enchanter/ench_check
playsound minecraft:block.note_block.pling master @s ~ ~ ~ 0.6 1.6
