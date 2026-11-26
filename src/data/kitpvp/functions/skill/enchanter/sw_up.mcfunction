# 金剑在主手且没满级：真正升一级
tag @s remove kitpvp.ench_wait
scoreboard players set @s kitpvp.ench_sw_fill 0
scoreboard players set @s kitpvp.ench_hint 0
scoreboard players remove @s kitpvp.ench_sw 3
scoreboard players add @s kitpvp.ench_sword 1
function kitpvp:skill/enchanter/roll_sword
effect give @s minecraft:glowing 5 0 true
playsound minecraft:entity.player.levelup master @s ~ ~ ~ 0.5 1.6
function kitpvp:skill/enchanter/name_refresh
