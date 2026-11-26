# 剑升一级：扣 3 点蓄力、等级 +1、掷一次剑附魔
scoreboard players remove @s kitpvp.ench_sw 3
scoreboard players add @s kitpvp.ench_sword 1
function kitpvp:skill/enchanter/roll_sword
execute if score @s kitpvp.ench_sword matches 11.. run scoreboard players set @s kitpvp.ench_sw 3
effect give @s minecraft:glowing 5 0 true
playsound minecraft:entity.player.levelup master @s ~ ~ ~ 0.5 1.6
tellraw @s [{"text":"\n[附魔师] ","color":"light_purple"},{"text":"剑附魔升到 ","color":"gray"},{"score":{"name":"@s","objective":"kitpvp.ench_sword"}},{"text":" 级","color":"white"}]
function kitpvp:skill/enchanter/name_refresh
