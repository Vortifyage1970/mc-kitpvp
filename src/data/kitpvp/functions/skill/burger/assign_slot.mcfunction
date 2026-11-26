# 分一条专属 bossbar 槽（1..8，取第一个没人占的）；蓄力进度只有自己看得到
execute unless score @s kitpvp.burger_slot matches 1.. unless entity @a[scores={kitpvp.burger_slot=1,kitpvp.kit=89}] run scoreboard players set @s kitpvp.burger_slot 1
execute unless score @s kitpvp.burger_slot matches 1.. unless entity @a[scores={kitpvp.burger_slot=2,kitpvp.kit=89}] run scoreboard players set @s kitpvp.burger_slot 2
execute unless score @s kitpvp.burger_slot matches 1.. unless entity @a[scores={kitpvp.burger_slot=3,kitpvp.kit=89}] run scoreboard players set @s kitpvp.burger_slot 3
execute unless score @s kitpvp.burger_slot matches 1.. unless entity @a[scores={kitpvp.burger_slot=4,kitpvp.kit=89}] run scoreboard players set @s kitpvp.burger_slot 4
execute unless score @s kitpvp.burger_slot matches 1.. unless entity @a[scores={kitpvp.burger_slot=5,kitpvp.kit=89}] run scoreboard players set @s kitpvp.burger_slot 5
execute unless score @s kitpvp.burger_slot matches 1.. unless entity @a[scores={kitpvp.burger_slot=6,kitpvp.kit=89}] run scoreboard players set @s kitpvp.burger_slot 6
execute unless score @s kitpvp.burger_slot matches 1.. unless entity @a[scores={kitpvp.burger_slot=7,kitpvp.kit=89}] run scoreboard players set @s kitpvp.burger_slot 7
execute unless score @s kitpvp.burger_slot matches 1.. unless entity @a[scores={kitpvp.burger_slot=8,kitpvp.kit=89}] run scoreboard players set @s kitpvp.burger_slot 8
