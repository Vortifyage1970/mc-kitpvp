# 冥王星（80）的共生：肩上的鹦鹉没了 => 隐形僵尸跟着倒
# 用 Passengers[0] 直接看乘客位：鹦鹉一死这个数据路径就空了，不需要守卫 marker
execute as @e[tag=kitpvp.earth_pluto_carrier] at @s unless data entity @s Passengers[0] run function kitpvp:skill/earth/pluto_die
