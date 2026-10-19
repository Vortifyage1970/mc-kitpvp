# 太阳耀斑：11 格内的其他玩家（不含自己）进入 5 秒短波通信干扰；锁 = 本技能自己的冷却（cd，15 秒）
tag @s add kitpvp.sun_self
execute as @a[tag=kitpvp.selected,tag=!kitpvp.spectator,tag=!kitpvp.sun_self,scores={kitpvp.alive=1},distance=..12] run function kitpvp:skill/sun/flare_hit
tag @s remove kitpvp.sun_self

# 清掉刷怪蛋刷出的蜜蜂
execute at @s run kill @e[type=minecraft:bee,tag=kitpvp.sun_flare_token,distance=..16]

scoreboard players set @s kitpvp.cd 300
tellraw @a [{"text":"☀　","color":"gold"},{"text":"领域展开：太阳耀斑","color":"yellow","bold":true},{"text":"　☀","color":"gold"}]
execute as @a at @s run playsound minecraft:entity.blaze.shoot master @s ~ ~ ~ 0.9 1.2
particle minecraft:flame ~ ~1 ~ 3 1.5 3 0.05 200
title @s actionbar {"text":"太阳耀斑：15 秒冷却","color":"gold"}
