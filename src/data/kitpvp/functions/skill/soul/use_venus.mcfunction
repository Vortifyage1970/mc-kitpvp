# 金星魂石：首行推进快照（ocelot 蛋只在本魂石里发）
scoreboard players operation @s kitpvp.soul_venus_last = @s kitpvp.soul_venus_used

execute at @s at @e[tag=kitpvp.soul_venus_token,distance=..8,sort=nearest,limit=1] run function kitpvp:skill/soul/venus_apply
# 老版本的蛋（加 EntityTag 之前发出去的）只带 display.Name，没有 tag：找不到 tag 时回退按名字
execute unless entity @e[tag=kitpvp.soul_venus_token,distance=..8] at @s at @e[type=minecraft:ocelot,name="金星魂石",distance=..8,sort=nearest,limit=1] run function kitpvp:skill/soul/venus_apply

execute at @s run kill @e[tag=kitpvp.soul_venus_token]
execute at @s run kill @e[type=minecraft:ocelot,name="金星魂石",distance=..8]
