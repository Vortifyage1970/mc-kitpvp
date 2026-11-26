# 给附魔师分一条专属 bossbar 槽（1..8，取第一个没人占的）
execute unless score @s kitpvp.ench_slot matches 1.. unless entity @a[scores={kitpvp.ench_slot=1,kitpvp.kit=98}] run scoreboard players set @s kitpvp.ench_slot 1
execute unless score @s kitpvp.ench_slot matches 1.. unless entity @a[scores={kitpvp.ench_slot=2,kitpvp.kit=98}] run scoreboard players set @s kitpvp.ench_slot 2
execute unless score @s kitpvp.ench_slot matches 1.. unless entity @a[scores={kitpvp.ench_slot=3,kitpvp.kit=98}] run scoreboard players set @s kitpvp.ench_slot 3
execute unless score @s kitpvp.ench_slot matches 1.. unless entity @a[scores={kitpvp.ench_slot=4,kitpvp.kit=98}] run scoreboard players set @s kitpvp.ench_slot 4
execute unless score @s kitpvp.ench_slot matches 1.. unless entity @a[scores={kitpvp.ench_slot=5,kitpvp.kit=98}] run scoreboard players set @s kitpvp.ench_slot 5
execute unless score @s kitpvp.ench_slot matches 1.. unless entity @a[scores={kitpvp.ench_slot=6,kitpvp.kit=98}] run scoreboard players set @s kitpvp.ench_slot 6
execute unless score @s kitpvp.ench_slot matches 1.. unless entity @a[scores={kitpvp.ench_slot=7,kitpvp.kit=98}] run scoreboard players set @s kitpvp.ench_slot 7
execute unless score @s kitpvp.ench_slot matches 1.. unless entity @a[scores={kitpvp.ench_slot=8,kitpvp.kit=98}] run scoreboard players set @s kitpvp.ench_slot 8
