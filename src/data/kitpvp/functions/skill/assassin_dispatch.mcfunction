# 令牌与魂石共用 enderman_spawn_egg，靠生成生物的 CustomName 分流
scoreboard players operation @s kitpvp.assassin_last = @s kitpvp.assassin_used

execute if score @s kitpvp.kit matches 4 at @s if entity @e[type=enderman,name="隐匿令牌",distance=..8] run function kitpvp:skill/assassin_cast

execute at @s if entity @e[type=enderman,name="刺客魂石",distance=..8] run function kitpvp:skill/soul/use_assassin
