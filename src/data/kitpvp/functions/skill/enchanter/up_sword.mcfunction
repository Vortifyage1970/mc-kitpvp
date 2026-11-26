# 剑升一级：金剑必须在主手；已到 11 级就只把蓄力钉住，不再往上涨
execute unless data entity @s SelectedItem{id:"minecraft:golden_sword"} run function kitpvp:skill/enchanter/sw_wait
execute if data entity @s SelectedItem{id:"minecraft:golden_sword"} unless score @s kitpvp.ench_sword matches ..10 run scoreboard players set @s kitpvp.ench_sw 3
execute if data entity @s SelectedItem{id:"minecraft:golden_sword"} if score @s kitpvp.ench_sword matches ..10 run function kitpvp:skill/enchanter/sw_up
