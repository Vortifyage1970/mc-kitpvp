# 先清所有海盗的弩再补发，避免"归还原弩"与"补发新弩"叠成两把（代价：正在拉弩会被打断）
execute as @a[scores={kitpvp.kit=9}] run clear @s minecraft:crossbow{KitCrossbow:1b}

execute as @a[scores={kitpvp.kit=9,kitpvp.alive=1},tag=!kitpvp.spectator] run function kitpvp:skill/pirate/give_crossbow

tellraw @a [{"text":"[!] ","color":"green","bold":true},{"text":"海盗的手炮已归还","color":"gray"}]
