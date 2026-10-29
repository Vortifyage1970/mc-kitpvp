# 地球魂石：首行推进快照（villager 蛋只在本魂石里发，不会和别的职业共用）
scoreboard players operation @s kitpvp.soul_earth_last = @s kitpvp.soul_earth_used

# 只认真的刷出了「地球魂石」的那次：以载体所在位置为落点（@s 仍是使用者，位置换成载体）
execute at @e[type=minecraft:villager,name="地球魂石",distance=..8,sort=nearest,limit=1] run function kitpvp:skill/soul/earth_apply

execute at @s run kill @e[type=minecraft:villager,name="地球魂石"]
