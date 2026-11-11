# 位置 = 玩家，@s = 玩家：找到脚边的载体蛋生物（豹猫），以它的位置调 venus_apply
execute at @e[tag=kitpvp.soul_venus_token,distance=..8,sort=nearest,limit=1] run function kitpvp:skill/soul/venus_apply
execute unless entity @e[tag=kitpvp.soul_venus_token,distance=..8] at @e[type=minecraft:ocelot,name="金星魂石",distance=..8,sort=nearest,limit=1] run function kitpvp:skill/soul/venus_apply

execute at @s run kill @e[tag=kitpvp.soul_venus_token]
execute at @s run kill @e[type=minecraft:ocelot,name="金星魂石",distance=..8]
