# 任何来源加了蓄力之后都走这里：满了就升一级
execute if score @s kitpvp.ench_sw matches 3.. run function kitpvp:skill/enchanter/up_sword
execute if score @s kitpvp.ench_ap matches 3.. run function kitpvp:skill/enchanter/up_armor
