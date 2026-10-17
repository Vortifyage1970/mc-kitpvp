# 太阳黑子：9 格内的其他玩家（不含自己）失明 10 秒；锁 = 本技能自己的冷却（cd2，40 秒，从使用时开始计）
tag @s add kitpvp.sun_self
execute as @a[tag=kitpvp.selected,tag=!kitpvp.spectator,tag=!kitpvp.sun_self,scores={kitpvp.alive=1},distance=..9] run function kitpvp:skill/sun/spot_hit
tag @s remove kitpvp.sun_self
# 刷怪蛋刷出的蝙蝠（tick 里也有兜底）
execute at @s run kill @e[type=minecraft:bat,tag=kitpvp.sun_spot_token,distance=..16]

scoreboard players set @s kitpvp.cd2 800
tellraw @a [{"text":"◐　","color":"dark_purple"},{"text":"太阳黑子","color":"yellow","bold":true},{"text":"　◐","color":"dark_purple"}]
execute as @a at @s run playsound minecraft:entity.illusioner.cast_spell master @s ~ ~ ~ 0.9 0.6
particle minecraft:squid_ink ~ ~1 ~ 2 1 2 0.02 120
title @s actionbar {"text":"太阳黑子：40 秒冷却","color":"dark_purple"}
