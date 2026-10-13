# 令牌与魂石共用 iron_golem_spawn_egg，靠生成生物的 CustomName 分流；distance 8 覆盖刷怪蛋右键射程
scoreboard players operation @s kitpvp.tank_last = @s kitpvp.tank_used

execute if score @s kitpvp.kit matches 3 at @s if entity @e[type=iron_golem,name="举盾令牌",distance=..8] run function kitpvp:skill/tank/cast

execute at @s if entity @e[type=iron_golem,name="坦克魂石",distance=..8] run function kitpvp:skill/soul/use_tank
