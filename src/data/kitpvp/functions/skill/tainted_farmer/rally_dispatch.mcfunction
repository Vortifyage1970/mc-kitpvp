# 尸壳蛋与僵尸魂石共用同一个 used 统计：首行无条件推进快照，再按载体名字分流（同 rise_dispatch）
scoreboard players operation @s kitpvp.tf_rally_last = @s kitpvp.tf_rally_used
execute at @s if entity @e[type=minecraft:husk,name="召集农民",distance=..8] run function kitpvp:skill/tainted_farmer/rally_do
