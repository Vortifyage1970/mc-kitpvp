# 混沌·农锄：与农夫同款手感，但混沌武器是 4 次耗材，所以只发效果、不产种子 / 小麦
scoreboard players operation @s kitpvp.farm_last = @s kitpvp.farm_used
execute if data entity @s SelectedItem.tag.ChaosBlade run effect give @s minecraft:speed 1 1 true
execute if data entity @s SelectedItem.tag.ChaosBlade run effect give @s minecraft:haste 1 0 true
