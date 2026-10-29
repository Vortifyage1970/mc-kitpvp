# 按上一刻手持的药剂分流；投出的那一瓶已被原版消耗，其余三瓶由各自的 fire_* 收走
execute if score @s kitpvp.pa_type_prev matches 1 run function kitpvp:skill/alchemist/fire_speed
execute if score @s kitpvp.pa_type_prev matches 2 run function kitpvp:skill/alchemist/fire_regen
execute if score @s kitpvp.pa_type_prev matches 3 run function kitpvp:skill/alchemist/fire_jump
execute if score @s kitpvp.pa_type_prev matches 4 run function kitpvp:skill/alchemist/fire_invis
