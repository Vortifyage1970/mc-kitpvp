# 剑不在主手：等级照升，掷骰排队到拿剑时补
tag @s remove kitpvp.ench_wait
scoreboard players remove @s kitpvp.ench_sw 3
scoreboard players add @s kitpvp.ench_sword 1
scoreboard players add @s kitpvp.ench_pending 1
effect give @s minecraft:glowing 5 0 true
playsound minecraft:entity.player.levelup master @s ~ ~ ~ 0.4 1.4
function kitpvp:skill/enchanter/name_refresh
title @s actionbar [{"text":"剑升到 ","color":"green"},{"score":{"name":"@s","objective":"kitpvp.ench_sword"},"color":"green"},{"text":" 级（拿剑时补附魔）","color":"gray"}]
