# 给附魔师分一条专属 bossbar 槽（1..8）
# ★ 不要用 etid 取模：玩家自己的 etid 每局都被清成 0（game/start_impl.mcfunction:38），
#   只有召唤物会拿到 1..6，所以两名附魔师会同时算成 "0 % 8 + 1 = 1" 号槽，
#   每刻互相覆盖同一条 bossbar —— 表现就是两个人时进度条来回跳（抽搐）。
# 改成「抢占 1..8 里第一个没被别的附魔师占用的槽」：先把自己置 0，再从 1 试到 8。
scoreboard players set @s kitpvp.ench_slot 0
execute unless entity @a[scores={kitpvp.kit=99,kitpvp.ench_slot=1},tag=!kitpvp.spectator] run scoreboard players set @s kitpvp.ench_slot 1
execute if score @s kitpvp.ench_slot matches 0 unless entity @a[scores={kitpvp.kit=99,kitpvp.ench_slot=2},tag=!kitpvp.spectator] run scoreboard players set @s kitpvp.ench_slot 2
execute if score @s kitpvp.ench_slot matches 0 unless entity @a[scores={kitpvp.kit=99,kitpvp.ench_slot=3},tag=!kitpvp.spectator] run scoreboard players set @s kitpvp.ench_slot 3
execute if score @s kitpvp.ench_slot matches 0 unless entity @a[scores={kitpvp.kit=99,kitpvp.ench_slot=4},tag=!kitpvp.spectator] run scoreboard players set @s kitpvp.ench_slot 4
execute if score @s kitpvp.ench_slot matches 0 unless entity @a[scores={kitpvp.kit=99,kitpvp.ench_slot=5},tag=!kitpvp.spectator] run scoreboard players set @s kitpvp.ench_slot 5
execute if score @s kitpvp.ench_slot matches 0 unless entity @a[scores={kitpvp.kit=99,kitpvp.ench_slot=6},tag=!kitpvp.spectator] run scoreboard players set @s kitpvp.ench_slot 6
execute if score @s kitpvp.ench_slot matches 0 unless entity @a[scores={kitpvp.kit=99,kitpvp.ench_slot=7},tag=!kitpvp.spectator] run scoreboard players set @s kitpvp.ench_slot 7
execute if score @s kitpvp.ench_slot matches 0 unless entity @a[scores={kitpvp.kit=99,kitpvp.ench_slot=8},tag=!kitpvp.spectator] run scoreboard players set @s kitpvp.ench_slot 8
# 8 条都被占满（第 9 名附魔师）就退回 1 号，至少还有条可挂
execute if score @s kitpvp.ench_slot matches 0 run scoreboard players set @s kitpvp.ench_slot 1
