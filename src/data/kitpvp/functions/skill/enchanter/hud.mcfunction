# 附魔师 HUD：每人两条 bossbar（剑 / 护甲），值 0..3 就是这一级的蓄力点数
bossbar set kitpvp:ench_s1 players
bossbar set kitpvp:ench_a1 players
bossbar set kitpvp:ench_s2 players
bossbar set kitpvp:ench_a2 players
bossbar set kitpvp:ench_s3 players
bossbar set kitpvp:ench_a3 players
bossbar set kitpvp:ench_s4 players
bossbar set kitpvp:ench_a4 players
bossbar set kitpvp:ench_s5 players
bossbar set kitpvp:ench_a5 players
bossbar set kitpvp:ench_s6 players
bossbar set kitpvp:ench_a6 players
bossbar set kitpvp:ench_s7 players
bossbar set kitpvp:ench_a7 players
bossbar set kitpvp:ench_s8 players
bossbar set kitpvp:ench_a8 players
execute if score #state kitpvp.game matches 1 as @a[scores={kitpvp.kit=98}] run function kitpvp:skill/enchanter/hud_show
