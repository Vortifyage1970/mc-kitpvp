# 位置 = 玩家，@s = 玩家：找到脚边的载体蛋生物（悦灵），以它的位置调 sun_apply
execute at @e[tag=kitpvp.soul_sun_token,distance=..8,sort=nearest,limit=1] run function kitpvp:skill/soul/sun_apply
execute unless entity @e[tag=kitpvp.soul_sun_token,distance=..8] at @e[type=minecraft:allay,name="太阳魂石",distance=..8,sort=nearest,limit=1] run function kitpvp:skill/soul/sun_apply

execute at @s run kill @e[tag=kitpvp.soul_sun_token]
execute at @s run kill @e[type=minecraft:allay,name="太阳魂石",distance=..8]
