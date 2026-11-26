# 一次强化事件：剑每轮都涨；护甲前 7 轮四件全涨，后 4 轮两件轮转
scoreboard players add @s kitpvp.ench_roll 1
function kitpvp:skill/enchanter/roll_sword
execute if score @s kitpvp.ench_roll matches ..7 run function kitpvp:skill/enchanter/roll_all_armor
execute if score @s kitpvp.ench_roll matches 8 run function kitpvp:skill/enchanter/roll_head_chest
execute if score @s kitpvp.ench_roll matches 9 run function kitpvp:skill/enchanter/roll_legs_feet
execute if score @s kitpvp.ench_roll matches 10 run function kitpvp:skill/enchanter/roll_head_legs
execute if score @s kitpvp.ench_roll matches 11 run function kitpvp:skill/enchanter/roll_chest_feet
scoreboard players set @s kitpvp.ench_timer 930
execute if score @s kitpvp.ench_roll matches 11.. run scoreboard players set @s kitpvp.ench_timer 1000000
function kitpvp:skill/enchanter/bar
