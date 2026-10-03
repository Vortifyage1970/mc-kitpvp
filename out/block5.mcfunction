# 每个魂石占一个区间，值落在区间内则命中
execute if score @s kitpvp.soul_rand matches 0..99 run function kitpvp:skill/soul_warrior
execute if score @s kitpvp.soul_rand matches 100..199 run function kitpvp:skill/soul_archer
execute if score @s kitpvp.soul_rand matches 200..399 run function kitpvp:skill/soul_tank
...
