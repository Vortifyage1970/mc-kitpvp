# 首行推进 last，漏写会每刻重复触发（铁律）
scoreboard players operation @s kitpvp.soul_ghost_last = @s kitpvp.soul_ghost_used

execute at @s run kill @e[type=vex,name="幽灵魂石"]

effect give @s minecraft:invisibility 20 0 true

tag @s add kitpvp.soul_ghost_active
scoreboard players set @s kitpvp.soul_ghost_timer 400
scoreboard players set @s kitpvp.ghost_minion_cd 0

title @s actionbar {"text":"魂石·幽影：隐身（20 秒），攻击玩家可召阴兵","color":"dark_aqua"}
playsound minecraft:entity.vex.ambient master @s ~ ~ ~ 0.8 1.0
