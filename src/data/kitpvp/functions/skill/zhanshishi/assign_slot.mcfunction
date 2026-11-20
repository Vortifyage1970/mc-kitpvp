# 分配 trap_id（1..6，取第一个没被本职业玩家占用的槽）；它同时也是陷阱虫的队槽 trap_<id>
scoreboard players set @s kitpvp.trap_id 0
execute unless score @s kitpvp.trap_id matches 1.. unless entity @a[scores={kitpvp.kit=77,kitpvp.trap_id=1}] run scoreboard players set @s kitpvp.trap_id 1
execute unless score @s kitpvp.trap_id matches 1.. unless entity @a[scores={kitpvp.kit=77,kitpvp.trap_id=2}] run scoreboard players set @s kitpvp.trap_id 2
execute unless score @s kitpvp.trap_id matches 1.. unless entity @a[scores={kitpvp.kit=77,kitpvp.trap_id=3}] run scoreboard players set @s kitpvp.trap_id 3
execute unless score @s kitpvp.trap_id matches 1.. unless entity @a[scores={kitpvp.kit=77,kitpvp.trap_id=4}] run scoreboard players set @s kitpvp.trap_id 4
execute unless score @s kitpvp.trap_id matches 1.. unless entity @a[scores={kitpvp.kit=77,kitpvp.trap_id=5}] run scoreboard players set @s kitpvp.trap_id 5
execute unless score @s kitpvp.trap_id matches 1.. unless entity @a[scores={kitpvp.kit=77,kitpvp.trap_id=6}] run scoreboard players set @s kitpvp.trap_id 6
# 兜底：满员时退回 1（两个陷阱师的陷阱虫会同队，但都不会攻击各自主人）
execute if score @s kitpvp.trap_id matches 0 run scoreboard players set @s kitpvp.trap_id 1
