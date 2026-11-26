# 蓄力：已过刻数 / 总周期 * 20 = 格子数，格子变了才重画
scoreboard players operation #ench_p kitpvp.game = @s kitpvp.ench_period
scoreboard players operation #ench_p kitpvp.game -= @s kitpvp.ench_timer
scoreboard players operation #ench_p kitpvp.game *= #ench_twenty kitpvp.game
scoreboard players operation #ench_p kitpvp.game /= @s kitpvp.ench_period
execute if score #ench_p kitpvp.game matches 21.. run scoreboard players set #ench_p kitpvp.game 20
execute if score #ench_p kitpvp.game matches ..-1 run scoreboard players set #ench_p kitpvp.game 0
scoreboard players operation #ench_sec kitpvp.game = @s kitpvp.ench_timer
scoreboard players operation #ench_sec kitpvp.game /= #ench_twenty kitpvp.game
execute unless score #ench_p kitpvp.game = @s kitpvp.ench_fill run function kitpvp:skill/enchanter/bar_draw
