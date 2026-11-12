# @s = 凤凰的守卫 marker：蛋在倒计时里被打碎了，这一轮不再复活
execute at @s run particle minecraft:smoke ~ ~0.4 ~ 0.4 0.4 0.4 0.02 24 force
execute at @s run playsound minecraft:block.fire.extinguish master @a ~ ~ ~ 1.2 1.0
execute at @s run tellraw @a [{"text":"[凤凰] 蛋碎了，这一轮不会再复活","color":"gray"}]
kill @s
kill @e[tag=kitpvp.phx_egg,distance=..4]
