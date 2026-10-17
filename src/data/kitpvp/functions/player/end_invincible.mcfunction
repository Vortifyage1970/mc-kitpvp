tag @s remove kitpvp.invincible
scoreboard players set @s kitpvp.inv 0

# 太阳（kit 65）每刻清效果并把无敌抗性按刻补回 1 秒；这里收掉那 1 秒余量，别让无敌偷偷延长
execute if score @s kitpvp.kit matches 65 run effect clear @s minecraft:resistance
