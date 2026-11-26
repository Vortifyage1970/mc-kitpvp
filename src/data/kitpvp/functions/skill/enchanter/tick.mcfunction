# 附魔师每刻：剑回到主手就摘掉等待标记，立刻把攒满的蓄力花掉；顺带把提示计时减一
execute if data entity @s SelectedItem{id:"minecraft:golden_sword"} run tag @s remove kitpvp.ench_wait
execute if data entity @s SelectedItem{id:"minecraft:golden_sword"} run function kitpvp:skill/enchanter/ench_check
execute if score @s kitpvp.ench_hint matches 1.. run scoreboard players remove @s kitpvp.ench_hint 1
