# 剑满 3 点：在主手就当场掷骰；不在主手就升级 + 排队
execute if data entity @s SelectedItem{id:"minecraft:golden_sword"} unless score @s kitpvp.ench_sword matches ..10 run scoreboard players set @s kitpvp.ench_sw 3
execute if data entity @s SelectedItem{id:"minecraft:golden_sword"} if score @s kitpvp.ench_sword matches ..10 run function kitpvp:skill/enchanter/sw_up
execute unless data entity @s SelectedItem{id:"minecraft:golden_sword"} if score @s kitpvp.ench_sword matches ..10 run function kitpvp:skill/enchanter/sw_queue
