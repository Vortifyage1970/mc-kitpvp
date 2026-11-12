# 重铸：清主手、随机换一把，冷却走全局 kitpvp.cd（30 秒 = 600 刻，tick 第 3 行统一递减）
scoreboard players set @s kitpvp.cd 600
playsound minecraft:block.beacon.activate master @s ~ ~ ~ 1 1.2
particle minecraft:enchanted_hit ~ ~1 ~ 0.5 0.5 0.5 0.1 20 normal
item replace entity @s weapon.mainhand with minecraft:air
title @s actionbar {"text":"混沌·重铸","color":"dark_purple"}
function kitpvp:kit/chaos_next
# 保险：万一这一摇没落到任何一把（理论上不会），再摇一次
execute unless data entity @s SelectedItem run function kitpvp:kit/chaos_next
