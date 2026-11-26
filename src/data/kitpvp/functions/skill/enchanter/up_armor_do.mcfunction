# 真正的护甲升级（未满级时）
scoreboard players remove @s kitpvp.ench_ap 3
scoreboard players add @s kitpvp.ench_armor 1
scoreboard players set @s kitpvp.ench_ap_fill 0
execute if score @s kitpvp.ench_armor matches 1..7 run function kitpvp:skill/enchanter/roll_all_armor
execute if score @s kitpvp.ench_armor matches 8 run function kitpvp:skill/enchanter/roll_head_chest
execute if score @s kitpvp.ench_armor matches 9 run function kitpvp:skill/enchanter/roll_legs_feet
execute if score @s kitpvp.ench_armor matches 10 run function kitpvp:skill/enchanter/roll_head_legs
execute if score @s kitpvp.ench_armor matches 11 run function kitpvp:skill/enchanter/roll_chest_feet
effect give @s minecraft:glowing 5 0 true
playsound minecraft:entity.player.levelup master @s ~ ~ ~ 0.5 1.2
tellraw @s [{"text":"\n[附魔师] ","color":"light_purple"},{"text":"护甲附魔升到 ","color":"gray"},{"score":{"name":"@s","objective":"kitpvp.ench_armor"}},{"text":" 级","color":"white"}]
function kitpvp:skill/enchanter/name_refresh
