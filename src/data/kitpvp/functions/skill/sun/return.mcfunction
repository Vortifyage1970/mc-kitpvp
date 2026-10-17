# 先清所有太阳的弓再补发，避免"归还原弓"与"补发新弓"叠成两把（代价：正在拉弓会被打断）
execute as @a[scores={kitpvp.kit=65}] run clear @s minecraft:bow{KitSunBow:1b}

execute as @a[scores={kitpvp.kit=65,kitpvp.alive=1},tag=!kitpvp.spectator] run function kitpvp:skill/sun/give_bow

tellraw @a [{"text":"[!] ","color":"green","bold":true},{"text":"太阳的弓已归还","color":"gray"}]
