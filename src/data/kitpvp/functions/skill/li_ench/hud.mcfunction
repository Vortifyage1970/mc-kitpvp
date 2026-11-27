# 附魔师 HUD：只清「这个槽没人占」的进度条
# ★ 不要每刻先把 16 条全清再重挂：客户端会把进度条当成"重新出现"，重播出现动画，
#   两个人时尤其明显（看着像抽搐）。有人占的槽交给 hud_show 原地写值/颜色。
execute unless entity @a[scores={kitpvp.kit=99,kitpvp.ench_slot=1},tag=!kitpvp.spectator] run bossbar set kitpvp:li_s1 players
execute unless entity @a[scores={kitpvp.kit=99,kitpvp.ench_slot=1},tag=!kitpvp.spectator] run bossbar set kitpvp:li_a1 players
execute unless entity @a[scores={kitpvp.kit=99,kitpvp.ench_slot=2},tag=!kitpvp.spectator] run bossbar set kitpvp:li_s2 players
execute unless entity @a[scores={kitpvp.kit=99,kitpvp.ench_slot=2},tag=!kitpvp.spectator] run bossbar set kitpvp:li_a2 players
execute unless entity @a[scores={kitpvp.kit=99,kitpvp.ench_slot=3},tag=!kitpvp.spectator] run bossbar set kitpvp:li_s3 players
execute unless entity @a[scores={kitpvp.kit=99,kitpvp.ench_slot=3},tag=!kitpvp.spectator] run bossbar set kitpvp:li_a3 players
execute unless entity @a[scores={kitpvp.kit=99,kitpvp.ench_slot=4},tag=!kitpvp.spectator] run bossbar set kitpvp:li_s4 players
execute unless entity @a[scores={kitpvp.kit=99,kitpvp.ench_slot=4},tag=!kitpvp.spectator] run bossbar set kitpvp:li_a4 players
execute unless entity @a[scores={kitpvp.kit=99,kitpvp.ench_slot=5},tag=!kitpvp.spectator] run bossbar set kitpvp:li_s5 players
execute unless entity @a[scores={kitpvp.kit=99,kitpvp.ench_slot=5},tag=!kitpvp.spectator] run bossbar set kitpvp:li_a5 players
execute unless entity @a[scores={kitpvp.kit=99,kitpvp.ench_slot=6},tag=!kitpvp.spectator] run bossbar set kitpvp:li_s6 players
execute unless entity @a[scores={kitpvp.kit=99,kitpvp.ench_slot=6},tag=!kitpvp.spectator] run bossbar set kitpvp:li_a6 players
execute unless entity @a[scores={kitpvp.kit=99,kitpvp.ench_slot=7},tag=!kitpvp.spectator] run bossbar set kitpvp:li_s7 players
execute unless entity @a[scores={kitpvp.kit=99,kitpvp.ench_slot=7},tag=!kitpvp.spectator] run bossbar set kitpvp:li_a7 players
execute unless entity @a[scores={kitpvp.kit=99,kitpvp.ench_slot=8},tag=!kitpvp.spectator] run bossbar set kitpvp:li_s8 players
execute unless entity @a[scores={kitpvp.kit=99,kitpvp.ench_slot=8},tag=!kitpvp.spectator] run bossbar set kitpvp:li_a8 players
execute unless entity @a[scores={kitpvp.kit=99,kitpvp.ench_slot=1},tag=!kitpvp.spectator] run bossbar set kitpvp:li_p1 players
execute unless entity @a[scores={kitpvp.kit=99,kitpvp.ench_slot=2},tag=!kitpvp.spectator] run bossbar set kitpvp:li_p2 players
execute unless entity @a[scores={kitpvp.kit=99,kitpvp.ench_slot=3},tag=!kitpvp.spectator] run bossbar set kitpvp:li_p3 players
execute unless entity @a[scores={kitpvp.kit=99,kitpvp.ench_slot=4},tag=!kitpvp.spectator] run bossbar set kitpvp:li_p4 players
execute unless entity @a[scores={kitpvp.kit=99,kitpvp.ench_slot=5},tag=!kitpvp.spectator] run bossbar set kitpvp:li_p5 players
execute unless entity @a[scores={kitpvp.kit=99,kitpvp.ench_slot=6},tag=!kitpvp.spectator] run bossbar set kitpvp:li_p6 players
execute unless entity @a[scores={kitpvp.kit=99,kitpvp.ench_slot=7},tag=!kitpvp.spectator] run bossbar set kitpvp:li_p7 players
execute unless entity @a[scores={kitpvp.kit=99,kitpvp.ench_slot=8},tag=!kitpvp.spectator] run bossbar set kitpvp:li_p8 players
execute if score #state kitpvp.game matches 1 as @a[scores={kitpvp.kit=99},tag=!kitpvp.spectator] at @s run function kitpvp:skill/li_ench/hud_show
