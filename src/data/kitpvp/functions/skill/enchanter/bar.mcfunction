# 附魔蓄力条：两发之间连续填充（20 格），满格就发一次
execute if score @s kitpvp.ench_roll matches 11 run title @s actionbar [{"text":"附魔等级 ","color":"light_purple"},{"text":"11","color":"gold"},{"text":" 级 ","color":"white"},{"text":"▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰","color":"gold"},{"text":"  MAX","color":"gold","bold":true}]
execute if score @s kitpvp.ench_roll matches ..10 run function kitpvp:skill/enchanter/bar_charge
