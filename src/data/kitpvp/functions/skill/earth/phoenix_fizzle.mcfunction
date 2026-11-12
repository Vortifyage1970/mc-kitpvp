# @s = 凤凰的守卫 marker：自己的蛋在倒计时里被打碎了，这一轮不再复活（不播报）
execute at @s run particle minecraft:smoke ~ ~0.4 ~ 0.4 0.4 0.4 0.02 24 force
execute at @s run playsound minecraft:block.fire.extinguish master @a ~ ~ ~ 1.2 1.0
execute at @s run kill @e[tag=kitpvp.phx_tmp,distance=..4]
kill @s
