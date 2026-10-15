# 先清所有里·弓箭手的弓再补发，避免"归还原弓"与"补发新弓"叠成两把（代价：正在拉弓会被打断）
execute as @a[scores={kitpvp.kit=24}] run clear @s minecraft:bow{KitTaintedBow:1b}

execute as @a[scores={kitpvp.kit=24,kitpvp.alive=1},tag=!kitpvp.spectator] run function kitpvp:skill/tainted_archer/give_bow

tellraw @a [{"text":"[!] ","color":"green","bold":true},{"text":"里·弓箭手的弓已归还","color":"gray"}]
